//
//  ListadoModel.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 1/5/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import Foundation

protocol ListadoModel
{
    func getListCharacter(_ completionHandler: @escaping (_ items: [ProtocolItem]) -> Void)
    func getMock(_ completionHandler: @escaping (_ items: [ProtocolItem]) -> Void)
}
