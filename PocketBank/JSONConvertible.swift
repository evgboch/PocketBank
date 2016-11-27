//
//  JSONConvertible.swift
//  PocketBank
//
//  Created by Евгений on 27.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONConvertible {
    
    func json() -> SwiftyJSON.JSON
    init(json: SwiftyJSON.JSON)
    
}
