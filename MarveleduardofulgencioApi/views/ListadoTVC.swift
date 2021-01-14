 //
//  ListadoTVC.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 1/5/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import UIKit

 class ListadoTVC: UITableViewController {
    
    // Elementos filtrados a utilizar en la tabla
    var filteredResults: [StructItem] = [StructItem]()
    // Elementos iniciales retorno del json en la llamada
    // Se puede añadir un atributo a la clase para que no utilizar dos arrays
    var initialResults: [StructItem] = [StructItem]()

    let tableRefreshControl = UIRefreshControl()
    var resultsController = UITableViewController()
    let searchController = UISearchController(searchResultsController: nil)

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
    
    private func creatingSearhBarInHeaderView() {
        tableView.tableHeaderView = self.searchController.searchBar
        searchController.searchBar.delegate = self
     }
    
    private func fillInitialResult() {
        initialResults.removeAll()
        for i in 0..<viewModel!.numberOfItems {
            initialResults.append(viewModel?.itemAtIndex(i) as! StructItem)
        }
        filteredResults = initialResults
    }
}
 
 extension ListadoTVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.searchBar.endEditing(true)
        filterValues(searchBar: searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredResults = initialResults
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func filterValues(searchBar: UISearchBar) {
        guard var searchQuery = searchController.searchBar.text else { return }
        tableRefreshControl.beginRefreshing()

        if searchQuery == "" {
          tableRefreshControl.endRefreshing()
          filteredResults = initialResults
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
          return
        }

        searchQuery = searchQuery.lowercased()
        filteredResults.removeAll()

        for i in 0..<initialResults.count {
            if initialResults[i].nombre.lowercased().contains(searchQuery) {
                filteredResults.append(initialResults[i])
            }
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
            if viewModel.numberOfItems > 0 && initialResults.count == 0 {
                fillInitialResult()
            }
            return filteredResults.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellpersonaje") as! CellPersonaje
         cell.item = filteredResults[(indexPath as NSIndexPath).row]
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

