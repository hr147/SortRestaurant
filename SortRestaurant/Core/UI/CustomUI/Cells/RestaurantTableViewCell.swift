//
//  RestaurantTableViewCell.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var currentSortTitleLabel: UILabel!
    @IBOutlet weak var currentSortValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension RestaurantTableViewCell {
    
    func configure(withRestaurant restaurant:Restaurant)  {
        nameLabel.text = restaurant.name
        statusLabel.text = restaurant.status.rawValue.uppercased()
    }
}
