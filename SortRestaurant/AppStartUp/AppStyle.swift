//
//  AppTheme.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

protocol AppStyling {
    func applyTheme()
}

struct AppStyle {
    
    private func configureNavigationBar() {
        let navigationBar = UINavigationBar.appearance()
        //navigationBar.barTintColor = #colorLiteral(red: 0.9411764706, green: 0.5215686275, blue: 0.2, alpha: 1)
        navigationBar.tintColor = .white
    }
    
    func configureSearchBar() {
        let searchBar = UISearchBar.appearance()
       // searchBar.backgroundColor = .white
        searchBar.searchBarStyle = .prominent
        searchBar.tintColor = .black
    }
}

extension AppStyle: AppStyling{
    
    func applyTheme() {
        configureNavigationBar()
        configureSearchBar()
    }
}
