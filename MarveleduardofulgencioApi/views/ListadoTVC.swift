 //
//  ListadoTVC.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 1/5/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import UIKit

class ListadoTVC: UITableViewController {
    

    var postShown = [Bool](repeating: false, count: 6)
    
    var viewModel: ListadoVM? {
        willSet {
            viewModel?.viewDelegate = nil
        }
        didSet {
            viewModel?.viewDelegate = self
            refreshDisplay()
        }
    }
    
    var isLoaded: Bool = false
    
    func refreshDisplay()
    {
        if let viewModel = viewModel , isLoaded {
            title = viewModel.title
        } else {
            title = ""
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.register(UINib(nibName: "CellPersonaje", bundle: nil), forCellReuseIdentifier: "cellpersonaje")
        
        isLoaded = true
        refreshDisplay();
    }
    
}

extension ListadoTVC
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let viewModel = viewModel {
            return viewModel.numberOfItems
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellpersonaje") as! CellPersonaje
        cell.item = viewModel?.itemAtIndex((indexPath as NSIndexPath).row)

        return cell
      
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        viewModel?.useItemAtIndex((indexPath as NSIndexPath).row)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
// For test mock use
//        if postShown[indexPath.row] {
//            return
//        }
//        postShown[indexPath.row] = true
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform

        UIView.animate(withDuration: 1.5, animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension ListadoTVC: ListadoVMViewDelegate
{
    func valoresDidChange(viewModel: ListadoVM)
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

