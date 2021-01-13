 //
//  ListadoTVC.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 1/5/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import UIKit

 class ListadoTVC: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    

    var filteredResults: [StructItem] = [StructItem]()
    var shouldShowSearchResults: Bool = false
    let tableRefreshControl = UIRefreshControl()
    var resultsController = UITableViewController()
    var searchController : UISearchController!

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
        
        UNService.shared.authorize()
    
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.register(UINib(nibName: "CellPersonaje", bundle: nil), forCellReuseIdentifier: "cellpersonaje")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        
        creatingSearhBarInHeaderView()
        
        isLoaded = true
        refreshDisplay();
    }
    
    func creatingSearhBarInHeaderView() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
     }
    
}
 
 extension ListadoTVC {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Pendiente de refactorizar
//        searchController.searchResultsController?.view.isHidden = false
//        guard var searchQuery = searchController.searchBar.text else { return }
//        tableRefreshControl.beginRefreshing()
//
//        if searchQuery == "" {
//          shouldShowSearchResults = false
//          tableRefreshControl.endRefreshing()
//          tableView.reloadData()
//          return
//        }
//
//        searchQuery = searchQuery.lowercased()
//        filteredResults.removeAll()
//
//        for i in 0..<viewModel!.numberOfItems {
//            if (viewModel?.itemAtIndex(i))!.nombre.lowercased().contains(searchQuery) {
//                filteredResults.append(viewModel?.itemAtIndex(i) as! StructItem)
//            }
//        }
//
//        tableView.reloadData()

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
        cell.imagenHablar.imagenView.load(url: URL(string:  (cell.item as! StructItem).finalyImage)!)

        return cell
      
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        viewModel?.useItemAtIndex((indexPath as NSIndexPath).row)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -100, 0, -100)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.5, animations: { cell.layer.transform = CATransform3DIdentity })
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

