//
//  PokemonController.swift
//  Pokemon app
//
//  Created by Scizor on 11/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class PokemonController: UIViewController {
    private let customView = PokemonView()
    private let viewModel: PokemonViewModel
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.trashButton.addTarget(self, action: #selector(removePokemonFromTeam), for: .touchUpInside)
    }
    
    init(model: DBPokemon) {
        self.viewModel = PokemonViewModel(pokemon: model)
        super.init(nibName: nil, bundle: nil)
        customView.setupInfos(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func removePokemonFromTeam() {
        viewModel.removePokemonFromTeam()
    }
}
