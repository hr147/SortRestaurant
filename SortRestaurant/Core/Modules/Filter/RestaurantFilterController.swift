//
//  RestaurantFilterController.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

final class RestaurantFilterController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    var filterDataSource: [String]!
    let valueDidSelect: Detectable<(value:String,index:Int)> = .init(value: ("",0))
    //MARK:- Private Methods
    
    private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Actions
    @IBAction func cancelTouchedUp(_ sender: UIBarButtonItem) {
        close()
    }
    
    @IBAction func selectTouchedUp(_ sender: UIBarButtonItem) {
        let row = pickerView.selectedRow(inComponent: 0)
        let value = filterDataSource[row]
        valueDidSelect.value = (value,row)
        close()
    }
    
}

extension RestaurantFilterController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterDataSource.count
    }
}

extension RestaurantFilterController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterDataSource[row]
    }
}
