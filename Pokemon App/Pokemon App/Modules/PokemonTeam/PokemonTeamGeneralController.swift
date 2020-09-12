//
//  PokemonTeamGeneralController.swift
//  Pokemon app
//
//  Created by Matheus Martins on 11/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import UIKit

final class PokemonTeamGeneralController: UIViewController {
    private let customView = PokemonTeamGeneralView()
    private let viewModel = PokemonTeamGeneralViewModel()
    private var pokemonControllers: [PokemonController] = []
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTeam),
            name: NSNotification.Name(rawValue: "UpdateLocalPokemons"),
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTeam()
    }
    
    private func addPokemons() {
        customView.stackView.removeArrangedSubviews()
        for controller in pokemonControllers {
            customView.stackView.addArrangedSubviews(views: [controller.view])
            addChild(controller)
            controller.didMove(toParent: self)
        }
    }
    
    @objc private func updateTeam() {
        pokemonControllers = []
        viewModel.getAllLocalPokemons().forEach { model in
            let model = PokemonModel(id: model.id, name: model.name, imageData: model.front, types: model.type)
            let controller = PokemonController(model: model)
            pokemonControllers.append(controller)
        }
        addPokemons()
    }
}
