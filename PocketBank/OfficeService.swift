//
//  OfficeService.swift
//  PocketBank
//
//  Created by Евгений on 27.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum OfficeServiceError: Error {
    
    case BaseError(String)
    
}


class OfficeService {
    
    func fetch(with boundingBox: BoundingBox, completion handler: @escaping (() throws -> [Office]?) -> Void) {
        
        let boundingComposite = boundingBox.urlCompositeString
        
        let urlString = _url + boundingComposite + _endURL
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let task = NetworkManager.dataTask(with: request) {(data, respose, error) in
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    
                    handler { throw OfficeServiceError.BaseError((error?.localizedDescription)!) }
                    return
                }
                
                if let officesJSON = SwiftyJSON.JSON(data:  data).array {
                    
                    let offices = officesJSON.map({ Office(json: $0) })
                    
                    handler { offices }
                    
                } else {
                    
                    handler { throw OfficeServiceError.BaseError(("Error JSON type")) }
                    
                }
            }
            
            
        }
        
        task.resume()

    }
    
    fileprivate var _url = "http://www.sberbank.ru/portalserver/proxy?pipe=branchesPipe&url=http%3A%2F%2Foib-rs%2Foib-rs%2FbyBounds%2Fentities%3F"
    
    fileprivate var _endURL = "%26size%3D9%26page%3D0%26cbLat%3D55.75396%26cbLon%3D37.620393%26filter%255Btype%255D%255B%255D%3Dfilial"
}


struct BoundingBox {
    
    var northeast: GPSCoordinate?
    var southwest: GPSCoordinate?
    
}



protocol NetworkRequestConvertable {
    
    var urlCompositeString: String { get }
    
}

extension BoundingBox: NetworkRequestConvertable {
    
    var urlCompositeString: String  {
        
        var string = String()
        
        if let se = southwest {
            
            string.append("llat%3D\(se.latitude)%26llon%3D\(se.longitude)%26")
            
        }
        
        if let nw = northeast {
            
            string.append("rlat%3D\(nw.latitude)%26rlon%3D\(nw.longitude)")
            
        }
        
        return string
        
    }
}

