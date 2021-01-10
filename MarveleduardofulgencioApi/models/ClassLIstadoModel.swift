//
//  ClassLIstadoModel.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 1/5/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import Foundation

class ClassListadoModel: ListadoModel
{
    
    fileprivate var items = [ProtocolItem]()
    
    init() {}
    
    func getMock(_ completionHandler: @escaping (_ items: [ProtocolItem]) -> Void)
    {
        ApiService.mockMarvel() { (result: [ProtocolItem]) in
            completionHandler(result)
        }
    }
    
    func getListCharacter(_ completionHandler: @escaping (_ items: [ProtocolItem]) -> Void)
    {
        ApiService.getListCharacter() { (result: [ProtocolItem]) in
            completionHandler(result)
        }
    }

}
   
