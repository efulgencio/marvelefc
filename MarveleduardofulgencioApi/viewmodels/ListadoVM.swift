//
//  ListadoVM.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 1/5/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import Foundation


protocol ListadoVMViewDelegate: class
{
    func valoresDidChange(viewModel: ListadoVM)
}

protocol ListadoVMCoordinatorDelegate: class
{
    func listadoVMDidSelectData(_ viewModel: ListadoVM, data: ProtocolItem)
}

protocol ListadoVM
{
    var model: ListadoModel? { get set }
    var viewDelegate: ListadoVMViewDelegate? { get set }
    var coordinatorDelegate: ListadoVMCoordinatorDelegate? { get set}
    
    var title: String { get }
    
    var numberOfItems: Int { get }
    func itemAtIndex(_ index: Int) -> ProtocolItem?
    func useItemAtIndex(_ index: Int)
}
