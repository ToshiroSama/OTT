//
//  Setting.swift
//  OTT
//
//  Created by Alisher Djuraev on 20/04/22.
//

import Foundation

class Setting: NSObject {
    let sizeName: SettingName
    let imageName: String
    
    init(sizeName: SettingName, imageName: String) {
        self.sizeName = sizeName
        self.imageName = imageName
    }
}

enum SettingName: String {
    case firstReso = "1080p"
    case secondReso = "720p"
    case thirdReso = "480p"
    case fourthReso = "360p"
}
