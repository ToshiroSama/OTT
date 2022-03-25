//
//  Channel.swift
//  OTT
//
//  Created by Alisher Djuraev on 24/03/22.
//

import Foundation

struct Channel {
    var id: Int  = 0
    var title: String = ""
    var image: String = ""
    
    init(id: Int, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
}
