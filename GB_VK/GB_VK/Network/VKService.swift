//
//  VKService.swift
//  GB_VK
//
//  Created by Anatoliy on 22.11.2021.
//

import Foundation
import RealmSwift

final class VKService {
    
    let session = Session.instance
    
    //MARK: - APIMethod
    enum APIMethod {
        case friends
        case photos(id: String)
        case groups
        case searchGroups(text: String)
        case newsFeed(type: NewsType)
        
        var path: String {
            switch self {
            case .friends:
                return "/method/friends.get"
            case .photos:
                return "/method/photos.getAll"
            case .groups:
                return "/method/groups.get"
            case .searchGroups:
                return "/method/groups.search"
            case .newsFeed:
                return "/method/newsfeed.get"
            }
        }
        
        var parameters: [String: String] {
            switch self {
            case .friends:
                return ["fields": "photo_100"]
            case .photos(let id):
                return ["owner_id": id, "need_hidden": "0", "count": "10", "skip_hidden": "1", "no_service_albums": "0", "extended": "1"]
            case .groups:
                return ["extended": "1"]
            case .searchGroups(let text):
                return ["q": text, "count": "10"]
            case .newsFeed(type: let type):
                return ["filters": type.stringValue]
            }
        }
    }
    
    enum NewsType {
        case post, photo, all
        
        var stringValue: String {
            switch self {
            case .post: return "post"
            case .photo: return "wall_photo"
            case .all: return "post, wall_photo"
                
            }
        }
    }
    
    //"https://api.vk.com/method/newsfeed.get?access_token=\()&v=5.131&filters=post,photo,wall_photo"
    //MARK: - запрос
    private func request(_ method: APIMethod, completion: @escaping (Data?) -> Void) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method.path
        
        let  defaultQueryItems = [URLQueryItem(name: "access_token", value: session.token),
                                  URLQueryItem(name: "v", value: "5.131")]
        
        let methodQueryItems = method.parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        components.queryItems = methodQueryItems + defaultQueryItems
        
        guard let url = components.url else {
            completion(nil)
            return
        }
        let URLSession = URLSession.shared
        let task = URLSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            print("ответ от сервера data")
            print(data)
            DispatchQueue.main.async {
                completion(data)
            }
            
        }
        task.resume()
    }
    
    //MARK: - друзья
    func getFriends(completion: @escaping () -> Void) {
        request(.friends) { [weak self] data in
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<User>.self, from: data)
                self?.saveToRealm(response.items)
                completion()
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - группы
    func getGroups(completion: @escaping ([Group]) -> Void) {
        request(.groups) { data in
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<Group>.self, from: data)
                completion(response.items)
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - фотографии
    func getPhotos(userId: String, completion: @escaping () -> Void) {
        request(.photos(id: userId)) { [weak self] data in //сюда передаем usrId, который пришел в функцию
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<Photo>.self, from: data)
                print("фотографии с сервера")
                print(response.items.count)
                self?.saveToRealm(response.items)
                completion()
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - поиск по группам
    func searchGroups(text: String, completion: @escaping ([Group]) -> Void) {
        request(.searchGroups(text: text)) { data in //сюда передаем usrId, который пришел в функцию
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<Group>.self, from: data)
                completion(response.items)
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - друзья
    func getNewsFeed(type: NewsType = .all, completion: @escaping ([VKNewsItem]) -> Void) {
        request(.newsFeed(type: type)) { data in
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<VKNewsItem>.self, from: data)
                
                completion(response.items)
            } catch {
                print(error)
            }
        }
    }
    
    //запись смписка друзей в Realm
    private func saveToRealm<T: Object>(_ objects: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            print(error)
        }
    }
}

