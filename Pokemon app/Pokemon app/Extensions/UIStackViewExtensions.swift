//
//  UIStackViewExtensions.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
        }
    }
    
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
