//
//  Channel.swift
//  OTT
//
//  Created by Alisher Djuraev on 24/03/22.
//

import Foundation

enum HeaderType: String, CaseIterable {
    case all = "ВСЕ"
    case uzbek = "УЗБЕК"
    case news = "НОВОСТИ"
    case nature = "ПРИРОДА"
}

struct Channel: Codable {
    let data: [ChannelItems]
}

struct ChannelItems: Codable {
    let id: Int
    let title: String
    let tv_link: String
    var image: String
    let category_id: Int
}
