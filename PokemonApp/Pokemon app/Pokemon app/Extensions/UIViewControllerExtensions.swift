//
//  UIViewControllerExtensions.swift
//  Pokemon app
//
//  Created by Matheus Martins on 10/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupTitle(_ title: String?, color: UIColor = .white) {
        let text = UILabel()
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = title?.capitalized
        text.textColor = color
        self.navigationItem.titleView = text
    }
}

