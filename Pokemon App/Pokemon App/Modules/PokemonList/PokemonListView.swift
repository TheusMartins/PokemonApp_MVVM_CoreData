
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
        label.isUserInteractionEnabled = true
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .projectBlack
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let picker: PokemonGenerationPickerView
    
    init(
        dataSource: UITableViewDataSource,
        delegate: UITableViewDelegate,
        pokemonGenerationPickerDelegate: PokemonGenerationPickerDelegate
    ) {
        picker = PokemonGenerationPickerView(delegate: pokemonGenerationPickerDelegate)
        super.init(frame: .zero)
        searchTextFieldTop = tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50)
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
    
    @objc private func showPicker() {
        addSubViews(views: [picker])
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension PokemonListView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [titleLabel, tableView])
    }
    
    func setupConstraints() {
        guard let searchTextFieldTop = searchTextFieldTop else { return }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            searchTextFieldTop,
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureViews() {
        self.backgroundColor = .projectBlack
        registerCells()
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPicker))
        titleLabel.addGestureRecognizer(tap)
    }
}

