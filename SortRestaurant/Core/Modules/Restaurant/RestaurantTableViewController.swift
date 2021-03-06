//
//  RestaurantTableViewController.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 09/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurantViewModel:RestaurantViewModeling!
    weak var dependency: DependencyContainer?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        restaurantViewModel.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        title = "Resturants"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterTouchedUp(_:)))
    }
    
    private func bindViewModel() {
        restaurantViewModel.refresh
            .subscribe = {[weak self] (Void) in
                self?.tableView.reloadData()
        }
        
        restaurantViewModel.filterNames
            .subscribe = {[weak self] filterTuple in
                self?.showFilter(withFilters: filterTuple.names, selectedIndex: filterTuple.selectedIndex)
        }
    }
    
    private func deActiveSearch() {
        navigationItem.searchController?.searchBar.resignFirstResponder()
    }
    
    private func showFilter(withFilters filters:[String],selectedIndex:Int) {
        guard let filterController = dependency?.filterController(withFilters: filters) else { return }
        filterController.defaultSelectedRow = selectedIndex
        filterController.valueDidSelect
            .subscribe = {[weak self] value in
                self?.restaurantViewModel.filterDidSelect(atIndex: value.index)
        }
        
        let source = presentedViewController ?? self
        source.present(filterController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RestaurantTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(withRestaurant: restaurantViewModel[indexPath.row])
        return cell
    }
    
    // MARK: - Actions
    
    @IBAction func favouriteTouchedUp(_ sender: UIButton) {
        deActiveSearch()
        if let indexPath = tableView.indexPath(for: sender){
            restaurantViewModel.favouriteStatusDidChange(atIndex: indexPath.row)
        }
    }
    
    @objc func filterTouchedUp(_ sender: UIBarButtonItem) {
        deActiveSearch()
        restaurantViewModel.filterDidTouch()
    }
}

extension RestaurantTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        restaurantViewModel.restaurantDidSearch(withName: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        restaurantViewModel.restaurantDidSearch(withName: "")
    }
}
