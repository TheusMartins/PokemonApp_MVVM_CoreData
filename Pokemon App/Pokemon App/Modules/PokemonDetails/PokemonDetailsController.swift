//
//  PokemonDetailsController.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class PokemonDetailsController: UIViewController {
    private let viewModel: PokemonDetailsViewModel
    private let customView = PokemonDetailsView()
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.getPokemon { [weak self] model in
                self?.customView.setupInfos(with: model)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.isHidden = false
    }
    
    init(pokemonName: String) {
        self.viewModel = PokemonDetailsViewModel(pokemonName: pokemonName)
        super.init(nibName: nil, bundle: nil)
        self.setupTitle(pokemonName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
