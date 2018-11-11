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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        restaurantViewModel.viewDidLoad()
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        title = "Resturants"
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterTouchedUp(_:)))
    }
    
    private func bindViewModel() {
        restaurantViewModel.refresh
            .subscribe = {[weak self] (Void) in
                self?.tableView.reloadData()
        }
        
        restaurantViewModel.filters
            .subscribe = { [weak self] filters in
                self?.showFilter(withFilters: filters)
        }
    }
    
    func showFilter(withFilters filters:[String]) {
        
        guard let filterController = dependency?.filterController(withFilters: filters) else { return }
        
        filterController.valueDidSelect.subscribe = {[weak self] value in
            self?.restaurantViewModel.filterDidSelect(atIndex: value.index)
        }
        
        present(filterController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantViewModel.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RestaurantTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(withRestaurant: restaurantViewModel[indexPath.row])
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    // MARK: - Actions
    @IBAction func favouriteTouchedUp(_ sender: UIButton) {
        
        
    }
    
    @objc func filterTouchedUp(_ sender: UIBarButtonItem) {
        restaurantViewModel.filterDidTouch()
    }
    
}
