//
//  UIViewExtensions.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import UIKit

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() {}
}

extension UIView {
    func addSubViews(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
