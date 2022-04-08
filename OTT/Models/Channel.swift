//
//  Channel.swift
//  OTT
//
//  Created by Alisher Djuraev on 24/03/22.
//

import Foundation

protocol ChannelProduct {
    var _id: Int { get }
    var _title: String { get }
    var _tvLink: String { get }
    var _image: String { get }
    var _categoryId: Int { get }
    var headerType: HeaderType { get }
}

enum HeaderType: Int, CaseIterable, Codable {
    case all = 0
    case uzbek = 2
    case news = 3
    case nature = 9
    
    func getTitle() -> String {
        switch self {
        case .all:
            return "ВСЕ"
        case .uzbek:
            return "УЗБЕК"
        case .news:
            return "НОВОСТИ"
        case .nature:
            return "ПРИРОДА"
        }
    }
}

struct Channel: Codable {
    var data: [ChannelItems]
}

struct ChannelItems: Codable {
    var id: Int
    var title: String
    var tv_link: String
    var image: String
    var category_id: Int
}

extension ChannelItems: ChannelProduct {
    var _id: Int { self.id }
    var _title: String { self.title }
    var _tvLink: String { self.tv_link }
    var _image: String { self.image }
    var _categoryId: Int { self.category_id }
    var headerType: HeaderType {
        switch self.category_id {
        case 3, 10:
            return HeaderType.news
        case 2:
            return HeaderType.uzbek
        case 9:
            return HeaderType.nature
        default:
            return .all
        }
    }
}
