//
//  TabBarController.swift
//  Pokemon app
//
//  Created by Scizor on 11/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    override var tabBarController: UITabBarController? {
        return UITabBarController()
    }
    
    private let pokemonListController: PokemonListController = {
        let controller = PokemonListController()
        controller.title = "Pokedex"
        return controller
    }()
    
    private let pokemonTeamController: PokemonTeamGeneralController = {
        let controller = PokemonTeamGeneralController()
        controller.setupTitle("Pokemon team")
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItens()
    }
    
    private func setupTabBarItens() {
        let listIcon = UIImage(named: "icPokedex")?.withRenderingMode(.alwaysTemplate)
        let teamIcon = UIImage(named: "icTeam")?.withRenderingMode(.alwaysTemplate)
        pokemonListController.tabBarItem = UITabBarItem(title: "Pokedex", image: listIcon, tag: 0)
        pokemonTeamController.tabBarItem = UITabBarItem(title: "Team", image: teamIcon, tag: 1)
        tabBarController?.tabBar.clipsToBounds = false
        viewControllers = [pokemonListController, pokemonTeamController]
        
        self.tabBar.barStyle = .black
        self.tabBar.tintColor = .primaryColor
    }
}
