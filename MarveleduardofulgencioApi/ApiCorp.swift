//
//  ApiCorp.swift
//  Wallbox
//
//  Created by WallBox on 17/11/16.
//  Copyright © 2016 eduardo fulgencio. All rights reserved.
//

import Foundation

//GET /sessions/list

class ApiCorp: ApiBase {
    
    var urltarget : String = ""
    let prefixString : String = "api/"
   
     // Default is charger
    var URLusGetSessionList : String {
        get {
            return ApiBase.urlbase +  "sessions/list/%@"
        }
    }

    var URLusGetSessionListByYear : String {
        get {
            return ApiBase.urlbase +  "sessions/list/%@?year=%@"
        }
    }
    
    var URLusGetSessionListByMonth : String {
        get {
           // return ApiBase.urlbase +  "sessions/list?view=" + PARAM_CHARGER_FOR_LOGS + "&year=%@&month=%@"
            return ApiBase.urlbase +  "sessions/list/%@?year=%@&month=%@"
        }
    }

    var URLusGetSessionListByWeek : String {
        get {
            //  return ApiBase.urlbase +  "sessions/list?view=" + PARAM_CHARGER_FOR_LOGS + "&year=%@&month=%@&day=%@"
            return ApiBase.urlbase +  "sessions/list/%@?year=%@&month=%@&week=%@"
        }
    }
    
    var URLusGetSessionListByDay : String {
        get {
          //  return ApiBase.urlbase +  "sessions/list?view=" + PARAM_CHARGER_FOR_LOGS + "&year=%@&month=%@&day=%@"
            return ApiBase.urlbase +  "sessions/list/%@?year=%@&month=%@&week=%@&day=%@"
        }
    }
    
    override init() {
        super.init()
    }
    
    
}
