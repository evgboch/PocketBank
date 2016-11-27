//
//  Office.swift
//  PocketBank
//
//  Created by Евгений on 27.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Office {
    
    var id: String?
    var coordinate: GPSCoordinate?
    var address: String?
    var phone: String?
    var name: String?
    
    
    var infoText: String {
        
        if let n = name, let a = address, let p = phone {
            
            return n + "\n" + a + "\n" + p
            
        }
        return ""
    }
}


extension GPSCoordinate : JSONConvertible {
    
    func json() -> JSON {
        return SwiftyJSON.JSON([ : ])
        
    }
    
    init(json: SwiftyJSON.JSON) {
        
        self.init()
        
        if let lat = json["latitude"].double, let lng = json["longitude"].double {
            
            self.latitude = lat
            self.longitude = lng
            
        }
    }
}

extension Office: JSONConvertible {
    
    func json() -> JSON {
        
        return SwiftyJSON.JSON([ : ])
        
    }
    
    init(json: SwiftyJSON.JSON) {
        
        self.init()
        
        self.id = json["id"].string
        let coordinates = json["coordinates"]
        
        self.coordinate = GPSCoordinate(json: coordinates)
        self.address = json["address"].string
        self.phone = json["phone"].string
        self.name = json["name"].string
        
    }
}
