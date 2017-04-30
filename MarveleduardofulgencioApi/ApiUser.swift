//
//  ApiUser.swift
//  Wallbox
//
//  Created by WallBox on 21/10/16.
//  Copyright © 2016 eduardo fulgencio. All rights reserved.
//

import UIKit

class ApiUser: ApiBase {

    var urltarget : String = ""
    static let prefixString : String = "api/"
    
    static func URLusGetUserToken() -> String {
       return ApiBase.urlbase + prefixString + "us_get_user_token"
    }
    
    /*
    public var URLusGetUserToken : String {
        get {
            return ApiBase.urlbase + prefixString + "us_get_user_token"
        }
    }
    
    var URLusGetChargerStatus : String {
        get {
           return ApiBase.urlbase +  "chargers/status/"
        }
    }
    
    
    
    var URLusGetChargersConfig : String {
        get {
            return ApiBase.urlbase +  "chargers/config/"
        }
    }
    
    public var URLusGetUserChargers : String {
        get {
            return ApiBase.urlbase + prefixString + "us_get_user_chargers"
        }
    }
   */
/*
    WB PULS 01 02A
       2    6
    WB (SIEMPRE WALLBOX)
    PULS / COMM (PULSAR O COMMANDER)
   
     01 (PISTOLA TIPO PUEDE SER 1 O 2)
    
   02 (COLOR:
     01 BLANCO 
     02 NEGRO 
     03 ARLEQUÍN)
    
     A ( RELEASE )
     
     JSON DE RETORNO
     LA IMAGEN SE TIENE LLAMAR 
     PULS01 pulsar blanco
     COMM02 commander negro
     {
     "part_number":"WBPULS0102A",
     "manufacture_date":null,
     "software_version":"1.0.0",
     "error":false,
     "status":200
     }
     
*/
    var URLusChargerSpec : String {
        get {
            return ApiBase.urlbase  + "chargers/spec/" // id del charger
        }
    }
    
          
    override init() {
        super.init()
    }
    
    
}
