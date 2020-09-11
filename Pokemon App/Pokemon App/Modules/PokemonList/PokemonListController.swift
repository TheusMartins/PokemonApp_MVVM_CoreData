//
//  PokemonListController.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class PokemonListController: UIViewController {
        private lazy var customView: PokemonListView = PokemonListView(dataSource: self,
                                                                       delegate: self,
                                                                       pokemonGenerationPickerDelegate: viewModel)
    private let viewModel: PokemonListViewModel
    
    init(viewmodel: PokemonListViewModel = PokemonListViewModel()) {
        self.viewModel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTableView),
            name: NSNotification.Name(rawValue: "UpdateInfos"),
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func updateTableView() {
        DispatchQueue.main.async {
            self.customView.tableView.reloadData()
        }
    }
}

extension PokemonListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.reuseIdentifier) as? PokemonCell else { return UITableViewCell() }
        cell.setupInfos(with: viewModel.getPokemonInfos(with: indexPath.row), pokemonIndex: indexPath.row)
        viewModel.getImage(at: indexPath.row) { image, hasError in
            DispatchQueue.main.async {
                cell.setupImage(image: image, hasError: hasError)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonDetailsController = PokemonDetailsController(pokemonName: viewModel.getPokemonName(at: indexPath.row))
        navigationController?.pushViewController(pokemonDetailsController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y <= 75 {
            customView.searchTextFieldTop?.constant = 75 - scrollView.contentOffset.y > 12 ? 75 - scrollView.contentOffset.y : 12
        } else if scrollView.contentOffset.y > 75 {
            customView.searchTextFieldTop?.constant = 12
        } else {
            customView.searchTextFieldTop?.constant = 75
        }
    }
}
