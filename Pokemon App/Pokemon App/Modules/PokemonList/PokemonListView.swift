
//
//  PokemonListView.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class PokemonListView: UIView {
    var searchTextFieldTop: NSLayoutConstraint?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pokemons"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
       
    private let searchTextField: SearchTextField
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .projectBlack
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(dataSource: UITableViewDataSource, delegate: UITableViewDelegate, searchTextFieldDelegate: SearchTextFieldDelegate) {
        searchTextField = SearchTextField(delegate: searchTextFieldDelegate)
        super.init(frame: .zero)
        searchTextFieldTop = searchTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 75)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.reuseIdentifier)
    }
}

extension PokemonListView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [titleLabel, searchTextField, tableView])
    }
    
    func setupConstraints() {
        guard let searchTextFieldTop = searchTextFieldTop else { return }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            searchTextFieldTop,
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureViews() {
        self.backgroundColor = .projectBlack
        registerCells()
    }
}

