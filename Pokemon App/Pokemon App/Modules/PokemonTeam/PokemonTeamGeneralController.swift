//
//  PokemonTeamGeneralController.swift
//  Pokemon app
//
//  Created by Scizor on 11/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class PokemonTeamGeneralController: UIViewController {
    private let customView = PokemonTeamGeneralView()
    private let viewModel = PokemonTeamGeneralViewModel()
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getAllLocalPokemons().forEach { model in
            let controller = PokemonController(model: model)
            customView.stackView.addArrangedSubviews(views: [controller.view])
            addChild(controller)
            controller.didMove(toParent: self)
        }
    }
}
