//
//  ApiService.swift
//  TestCompletionFunction
//
//  Created by Eduardo Fulgencio on 27/4/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import Foundation



class ApiService {
    
    static var apiUser : ApiUser = ApiUser()
    static var modelBase : ModelBase!
    
    class func hardProcessingWithString(input: String, completion: (_ result: String) -> Void) {
        
        completion("cuando finalice de retornar el servicio tendré los datos")
        
    }
    
    class func hardProcessingWithModelBase(completion: (_ result: ModelBase) -> Void) {
        
        let modelBase = ModelBase(valor: "2020")
        
        completion(modelBase!)
        
    }

    
     class func hardProcessingWithObject(input: String, completion: @escaping (_ result: ModelBase) -> Void) {
        
        var modelBase = ModelBase()

        
        guard let url = URL(string: ApiUser.URLusGetUserToken() ) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        //   urlRequest.addValue("Bearer " + idTokenSession, forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: urlRequest) {    (data, response, error) in
            
            guard error == nil else {
                print(error as Any)
                //  self.errorValue = "getChargers call : " + (error?.localizedDescription)!
                return
            }
            
            
            guard let responseData = data else {
                print("Error: did not receive data")
                //   self.errorValue = "getChargers call : assing data to responseData"
                return
            }

            do {
                guard let jsonFromData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    //      self.errorValue = "getChargers : convert data to JSON"
                    return
                }
                
                // print(jsonFromData.description)
                
                // only 1 time
                /*
                 if let userChargersModel = ModelBase(json: jsonFromData) {
                 self.userChargers = userChargersModel
                 }
                */
                
                completion(modelBase)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }

            
        }
        
            completion(modelBase)
        task.resume()
        
   
        
    }

    
    
    
    
    
}


