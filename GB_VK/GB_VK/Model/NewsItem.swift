//
//  NewsItem.swift
//  GB_VK
//
//  Created by Anatoliy on 18.12.2021.
//

import Foundation

enum NewsItemType: String {
    case post
    case image
    case wallPhoto = "wall_photo"
}

struct NewsItem {
    var author: String
    var postDate: String
    var text: String?
    var photo: String?
    var type: NewsItemType
    
    static let fake: [NewsItem] = (1...10).map { _ in
        NewsItem(author: "Николай Васильевич",
                 postDate: "01.11.2021",
                 text: "Давайте в день, когда повезём кронблок на терминал транспортной компании, я с вами заранее свяжусь.На терминале упакуют и посчитают окончательную стоимость доставки, после чего я вышлю фото кронблока на терминале и фото накладной. Вы оплатите 20.000 + доставку по накладной",
                 photo: "test",
                 type: Bool.random() ? .post : .image)
    }
}

struct VKNewsItem: Decodable {
    
}
