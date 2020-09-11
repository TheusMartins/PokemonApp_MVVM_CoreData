//
//  SearchTextField.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

protocol SearchTextFieldDelegate: class {
    func textFieldText(_ string: String)
}

import UIKit

final class SearchTextField: UIView {
    private let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icSearch")
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icClose"), for: .normal)
        return button
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .clear
        field.attributedPlaceholder = NSAttributedString(
                string: "Search Pokemon",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]
        )
        field.borderStyle = .none
        field.textColor = .white
        return field
    }()
    
    private weak var delegate: SearchTextFieldDelegate?
    
    init(delegate: SearchTextFieldDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func hideCloseButton(hide: Bool) {
        closeButton.isHidden = !hide
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
    }
    
    @objc private func dissmiss() {
        textField.text = ""
        delegate?.textFieldText("")
        closeButton.isHidden = true
    }
    
    private func setupLayout(isFirstResponder: Bool) {
        layer.borderColor = isFirstResponder ? UIColor.white.cgColor : UIColor.clear.cgColor
    }
}

extension SearchTextField: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [searchIconImageView, closeButton, textField])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //searchIconImageView
            searchIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchIconImageView.heightAnchor.constraint(equalToConstant: 24),
            searchIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            //closeIconImageView
            closeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            
            //textField
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: searchIconImageView.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            //SearchTextField
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureViews() {
        setupCloseButton()
        closeButton.isHidden = true
        textField.delegate = self
        backgroundColor = .darkGray
        layer.cornerRadius = 25
        layer.borderWidth = 1
        clipsToBounds = true
    }
}

extension SearchTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupLayout(isFirstResponder: textField.isFirstResponder)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setupLayout(isFirstResponder: textField.isFirstResponder)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = textField.text else { return false }
        if string == "" {
            text = "\(text.dropLast())"
        } else {
           text = text + string
        }
        delegate?.textFieldText(text)
        hideCloseButton(hide: text.count >= 1)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

