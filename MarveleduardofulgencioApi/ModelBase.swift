//
//  ModelBase.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 27/4/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import Foundation

struct ModelBase {
    var idSn : String = ""
    var partnumber : String = ""
    var softwareversion : String = ""
    var nameimage : String = ""
}

extension ModelBase {
    
    init?(json: [String: AnyObject] , idSnIn: String) {
        
        guard let partnumber : String = json["part_number"] as! String?,
            let softwareversion : String = json["software_version"] as! String?
            else {
                return nil
        }
        
        self.partnumber = partnumber
        self.softwareversion = softwareversion
        self.idSn = idSnIn
        self.nameimage = "" // "COMM01"
        
        if(partnumber != "") {
            let c : String = partnumber
            let typecharger : String = (c[c.index(c.startIndex, offsetBy: 2) ..< c.index(c.endIndex, offsetBy: -5)])
            let colorcharger : String = (c[c.index(c.startIndex, offsetBy: 8) ..< c.index(c.endIndex, offsetBy: -1)])
            self.nameimage = typecharger + colorcharger
        }
        
    }
    
    init?(valor: String) {
        self.idSn = valor
    }
    
}
