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
    case firstDimension = "1080p"
    case secondDimension = "720p"
    case thirdDimension = "480p"
    case fourthDimension = "360p"
}
