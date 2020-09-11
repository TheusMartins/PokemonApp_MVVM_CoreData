
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
        label.text = "Select generation"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    private let showPickerButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "iconArrowDown")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .primaryColor
        return button
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
        searchTextFieldTop = tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60)
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
    
    private func setupshowPickerButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPicker))
        showPickerButton.addGestureRecognizer(tap)
    }
    
    @objc private func showPicker() {
        addSubViews(views: [picker])
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PokemonListView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [titleLabel, showPickerButton, tableView])
    }
    
    func setupConstraints() {
        guard let searchTextFieldTop = searchTextFieldTop else { return }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            showPickerButton.heightAnchor.constraint(equalToConstant: 24),
            showPickerButton.widthAnchor.constraint(equalToConstant: 24),
            showPickerButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            showPickerButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            
            searchTextFieldTop,
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureViews() {
        self.backgroundColor = .projectBlack
        registerCells()
        setupshowPickerButton()
    }
}

