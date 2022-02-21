//
//  VKNewsfeedService.swift
//  GB_VK
//
//  Created by Anatoliy on 25.12.2021.
//

import Foundation
import SwiftyJSON

final class VKNewsfeedService {
    
    let session = Session.instance
    
    func get (startTime: TimeInterval? = nil,
              startFrom: String? = nil,
              completion: @escaping ([NewsfeedItem], String) -> Void) {
        
        var urlPath = "https://api.vk.com/method/newsfeed.get?access_token=\(session.token)&v=5.131&filters=post,wall_photo&count=20"
        //photo,wall_photo
        if let startTime = startTime {
            urlPath += "&start_time=\(Int(startTime))"
        }
        
        if let startFrom = startFrom {
            urlPath += "&start_from=\(startFrom)"
        }
        
        guard let url = URL(string: urlPath) else {
            completion([], "")
            return
        }
        print(url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion([], "")
                }

                return
            }
            let (items, nextFrom) = strongSelf.parse(data)
            DispatchQueue.main.async {
                completion(items, nextFrom)
            }
        }
        task.resume()
    }
    
    func parse(_ data: Data?) -> ([NewsfeedItem], String) {
        guard let data = data else { return ([], "") }
        do {
            let json = try JSON(data: data)
            
            let items = json["response"]["items"]
                .arrayValue
                .map { NewsfeedItem(json: $0) }
            let profiles = json["response"]["profiles"]
                .arrayValue
                .map { NewsfeedProfile(json: $0) }
            let groups = json["response"]["groups"]
                .arrayValue
                .map { NewsFeedGroup(json: $0) }
            
            let newItems =  connectItems(items,
                                         profiles: profiles,
                                         groups: groups)
            let nextFrom = json["response"]["next_from"].stringValue
            return (newItems, nextFrom)
        } catch {
            print(error)
            return ([], "")
        }
    }
    
    func connectItems(_ items: [NewsfeedItem],
                      profiles: [NewsfeedProfile],
                      groups: [NewsFeedGroup]) -> [NewsfeedItem] {
        
        var newItems: [NewsfeedItem] = []
        
        for item in items {
            var newItem = item
            if item.sourceId > 0 {
                let profile = profiles
                    .filter({ item.sourceId == $0.id})
                    .first
                newItem.author = profile?.name
                newItem.authorImageUrl = profile?.imageUrl
            } else {
                let group = groups
                    .filter({ abs(item.sourceId) == $0.id })
                    .first
                newItem.author = group?.title
                newItem.authorImageUrl = group?.imageUrl
            }
            
            newItems.append(newItem)
        }
        return newItems
    }
}

struct NewsfeedItem {
    var sourceId: Int
    var text: String
    var date: Double
    var author: String?
    var authorImageUrl: String?
    var type: NewsItemType
    var photo: NewsFeedPhoto?
    
    init(json: JSON) {
        self.sourceId = json["source_id"].intValue
        self.text = json["text"].stringValue
        self.date = json["date"].doubleValue
        self.type = NewsItemType(rawValue: json["type"].stringValue) ?? .image
        
        if let photoJson = json["photos"]["items"].arrayValue.first?["sizes"].arrayValue[2] {
            self.photo = NewsFeedPhoto(json: photoJson)
        }
            
        //self.imageUrl = json["photos"]["items"].arrayValue.first?["sizes"].arrayValue[2]["url"].stringValue - первоначальный вариант
        //self.imageUrl = json["photos"]["items"].arrayValue.first?["photo_604"].stringValue - вариант из урока
    }
}

struct NewsfeedProfile {
    var id: Int
    var name: String
    var imageUrl: String?
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue
        self.imageUrl = json["photo_100"].stringValue
    }
}

struct NewsFeedGroup {
    var id: Int
    var title: String
    var imageUrl: String?
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["name"].stringValue
        self.imageUrl = json["photo_100"].stringValue
    }
}

struct NewsFeedPhoto {
    var imageUrl: String
    var height: Int
    var width: Int
    
    init(json: JSON) {
        self.imageUrl = json["url"].stringValue
        self.height = json["height"].intValue
        self.width = json["width"].intValue
    }
}
