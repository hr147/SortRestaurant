//
//  AlertMessageWireframe.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

struct AlertMessageWireframe: MessageWireframe {
    
    unowned let source:UIViewController

    func show(withMessage message: String) {
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        controller.addAction(okAction)
        source.present(controller, animated: true, completion: nil)
    }
}
