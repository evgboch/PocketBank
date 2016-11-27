//
//  NetworkManager.swift
//  PocketBank
//
//  Created by Евгений on 27.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import Foundation


class NetworkManager {
    
    public static func dataTask(with request: URLRequest, completion handler:@escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return _urlSession.dataTask(with: request, completionHandler: { (d, r, e) in
            handler(d, r as? HTTPURLResponse, e)
        })
        
    }
    
    static var _urlSession: URLSession {
        
        return URLSession(configuration: .default)
        
    }
}
