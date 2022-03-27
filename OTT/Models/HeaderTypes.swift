//
//  NavigationChannel.swift
//  OTT
//
//  Created by Alisher Djuraev on 23/03/22.
//

import Foundation

enum HeaderType: String, CaseIterable {
    case all = "ВСЕ"
    case news = "НОВОСТИ"
    case sport = "СПОРТ"
    case nature = "ПРИРОДА"
}

struct HeaderTypes {
   var navChannel: String = ""
    
    init(navChannel: String) {
        self.navChannel = navChannel
    }
}
