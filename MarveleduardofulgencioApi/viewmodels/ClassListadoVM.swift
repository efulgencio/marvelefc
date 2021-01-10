//
//  ClassListadoVM.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 1/5/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import Foundation

class ClassListadoVM: ListadoVM
{
    
    weak var viewDelegate: ListadoVMViewDelegate?
    weak var coordinatorDelegate: ListadoVMCoordinatorDelegate?
    
    fileprivate var items: [ProtocolItem]? {
        didSet {
            viewDelegate?.valoresDidChange(viewModel: self)
        }
    }
    
    // ListadoModel call to service for get the items
    var model: ListadoModel? {
        didSet {
            items = nil;
// /* uncomment for use local mock
            model?.getMock({ (items) in
                self.items = items
            })
// */
    
/* uncomment for use marvel url server
            model?.getListCharacter({ (items) in
                self.items = items
            })
*/
        }
    }
    
    
    var title: String {
        return "List"
    }
    
    var numberOfItems: Int {
        if let items = items {
            return items.count
        }
        return 0
    }
    
    func itemAtIndex(_ index: Int) -> ProtocolItem?
    {
        if let items = items , items.count > index {
            return items[index]
        }
        return nil
    }
    
    func useItemAtIndex(_ index: Int)
    {
        if let items = items, let coordinatorDelegate = coordinatorDelegate  , index < items.count {
            coordinatorDelegate.listadoVMDidSelectData(self, data: items[index])
        }
    }
}
