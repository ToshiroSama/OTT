//
//  ChannelService.swift
//  OTT
//
//  Created by Alisher Djuraev on 08/04/22.
//

import Foundation

enum MimeType: String {
    case json
    case grpc
}

class ChannelService: NSObject {
    static let shared: ChannelService = { $0 }(ChannelService())
    
    var channels: [ChannelItems] = []
    
    override init() {
        super.init()
        parseJSON()
    }
    
    func parseJSON() {
        let bundle = Bundle.main
        let type = MimeType.json.rawValue
        
        guard let path = bundle.path(forResource: "data", ofType: type) else {
            print("Error")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            self.channels = try JSONDecoder()
                .decode(Channel.self, from: jsonData)
                .data
        } catch {
            print("Error \(error)")
        }
    }
}
