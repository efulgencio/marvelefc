//
//  ApiService.swift
//  TestCompletionFunction
//
//  Created by Eduardo Fulgencio on 27/4/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import Foundation

// list
// https://gateway.marvel.com:443/v1/public/characters?apikey=46996a2c4fafc17be9ee1914774decd5
// public key
// single
// https://gateway.marvel.com:443/v1/public/characters/1011334?apikey=46996a2c4fafc17be9ee1914774decd5

public struct MarvelCheckRequest: Codable {
    var copyright: String
    var code: Int
    var status: String
    
//    enum CodingKeys: String, CodingKey {
//      case copyright, code,  status
//    }
}

public struct Elementos: Codable {
    var result: [Personaje]
}

public struct Personaje: Codable {
    var name: String
}

class ApiService {
    

    class func mockMarvel(completion: (_ result: [ProtocolItem]) -> Void) {
        
        var protocolItems : [ProtocolItem] = [ProtocolItem]()
        
        protocolItems.append(StructItem(cadenainicio: "PERSONAJE 1:imgpersonaje1:descripcion personaje 1:hola soy el personaje número uno"))
        protocolItems.append(StructItem(cadenainicio: "PERSONAJE 2:imgpersonaje2:descripcion personaje 2:hola soy el personaje número dos "))
        protocolItems.append(StructItem(cadenainicio: "PERSONAJE 3:imgpersonaje3:descripcion personaje 3:hola soy el personaje número tres"))
        protocolItems.append(StructItem(cadenainicio: "PERSONAJE 4:imgpersonaje4:descripcion personaje 4:hola soy el personaje número cuatro"))
        protocolItems.append(StructItem(cadenainicio: "PERSONAJE 5:imgpersonaje5:descripcion personaje 5:hola soy el personaje número cinco"))

        completion(protocolItems)
        
    }
    
    class func getListCharacter(completion: @escaping (_ result: [ProtocolItem]) -> Void) {
       
        var protocolItems = [ProtocolItem]()

        guard let url = URL(string: String(format: ApiCharacter.urlList.rawValue, URL_BASE, Constants.publicKey.rawValue)) else {
           return
       }
       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "GET"
       urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
       let session = URLSession(configuration: URLSessionConfiguration.default)
       
       let task = session.dataTask(with: urlRequest) {    (data, response, error) in
           
           guard error == nil else {  return  }
           guard let responseData = data else { return }
        
           do {
               guard (try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject]) != nil else {
                   return
               }
            
                if let jsonArray = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject]
                {
                    if let marvelCheckRequest = try JSONDecoder().decode(MarvelCheckRequest.self, from: responseData) as MarvelCheckRequest? {
                        if marvelCheckRequest.status.uppercased() == "OK" {
                            for contentElements in jsonArray{
                                    if contentElements.key == "data" {
                                        if let characters  = contentElements.value["results"] as! NSArray? {
                                            for characterDict in characters {
                                                protocolItems.append(StructItem(character: characterDict as! NSDictionary))
                                            }
                                        }
                                    }
                            }
                            completion(protocolItems)
                        }
                    }
                } else {
                    completion(protocolItems)
                }
           } catch  {
               return
           }
       }
       task.resume()
  
   }
}


