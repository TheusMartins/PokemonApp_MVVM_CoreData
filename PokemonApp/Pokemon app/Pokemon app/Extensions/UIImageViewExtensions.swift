//
//  UIImageViewExtensions.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import UIKit

extension UIImageView {
    func showLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        self.addSubViews(views: [activityIndicator])
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        guard let activityIndicator = subviews.last as? UIActivityIndicatorView else { return }
        
        activityIndicator.removeFromSuperview()
    }
}
