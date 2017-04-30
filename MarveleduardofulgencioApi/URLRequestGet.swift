//
//  URLRequest.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 27/4/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import Foundation


class URLRequestFactory {
    
    static func URLRequestGet(urlin: String) ->  URLRequest {
        
        guard let url = URL(string: ApiUser.URLusGetUserToken()) else {
            print("Error: cannot create URL")
            return URLRequest(url: URL(string:"")!)
        }

        let object : URLRequest = URLRequest(url: url)
    
        return object
    }
    
     
}
