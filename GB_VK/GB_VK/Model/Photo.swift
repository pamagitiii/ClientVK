//
//  Photo.swift
//  GB_VK
//
//  Created by Anatoliy on 23.11.2021.
//

import Foundation
import RealmSwift

final class Photo: Object, Decodable {

    @objc dynamic var likesCount: Int = 0
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    
    static override func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case likesCount = "count"
        case sizes
        case likes
        case url
        case type
        case id
        case ownerId = "owner_id"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        //получаем основной контейнер
        let container = try decoder.container(keyedBy: CodingKeys.self)

        //получаем массив с размерами фотографии и ссылками на них
        var sizesContainer = try container.nestedUnkeyedContainer(forKey: .sizes)
        var sizes: [String : String] = [:]
        
        while !(sizesContainer.isAtEnd) {
            let allSizesContainer = try sizesContainer.nestedContainer(keyedBy: CodingKeys.self)
            let type = try allSizesContainer.decode(String.self, forKey: .type)
            let url = try allSizesContainer.decode(String.self, forKey: .url)
            sizes[type] = url
        }
        self.photoUrl = sizes["q"] ?? ""

        //получаем количесвто лайков на фотографии
        let likesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .likes)
        self.likesCount = try likesContainer.decode(Int.self, forKey: .likesCount)
        
        //получаем ID фотографии
        self.id = try container.decode(Int.self, forKey: .id)
        
        //получаем ID пользователя для использованяи в primary key
        self.ownerId = try container.decode(Int.self, forKey: .ownerId)
    }
}

// вариант со вложенной структурой, который использовался только для получения данных из сети
/*
struct Photo: Decodable {
    
    let photoSizes: [PhotoSize]
    let likesCount: Int
    var photoUrl: String {
        return photoSizes.first(where: {$0.type == "q"})?.url ?? ""
    }
    
    //вложенная структура для хранения массива размеров фоток
    struct PhotoSize: Decodable {
        let url: String
        let type: String
    }
    
    enum CodingKeys: String, CodingKey {
        
        case likesCount = "count"
        case sizes
        case likes
        case url
        case type
    }
    
    init(from decoder: Decoder) throws {
        //получаем основной контейнер
        let container = try decoder.container(keyedBy: CodingKeys.self)

        //получаем массив с размерами фотографии и ссылками на них
        self.photoSizes = try container.decode([PhotoSize].self, forKey: .sizes)
        
        //получаем количесвто лайков на фотографии
        let likesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .likes)
        self.likesCount = try likesContainer.decode(Int.self, forKey: .likesCount)
    }
}
*/

/*
struct Photo: Decodable {
    let photoURL: String
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case photoURL = "url"
        case likesCount = "count"
        case sizes
        case likes
    }
    
    init(from decoder: Decoder) throws {
        //получаем основной контейнер
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //заходим в массив с размерами картинок
        var sizesArrayContainer = try container.nestedUnkeyedContainer(forKey: .sizes)
        
        //здесь мы обращаемся к массиву три раза пока sizesArrayContainer.currentIndex не станет 3 чтобы обратиться к размеру фотографии, которая лежит в третьей по счёту в массиве фотографий
        _ = try sizesArrayContainer.nestedContainer(keyedBy: CodingKeys.self)
        _ = try sizesArrayContainer.nestedContainer(keyedBy: CodingKeys.self)
        _ = try sizesArrayContainer.nestedContainer(keyedBy: CodingKeys.self)
        let fourthSizeContainer = try sizesArrayContainer.nestedContainer(keyedBy: CodingKeys.self)
        self.photoURL = try fourthSizeContainer.decode(String.self, forKey: .photoURL)
        //self.photoURL = try sizeContainer.decode(String.self, forKey: .photoURL)
        
        //получаем количесвто лайков на фотографии
        let likesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .likes)
        self.likesCount = try likesContainer.decode(Int.self, forKey: .likesCount)
    }
}
*/
