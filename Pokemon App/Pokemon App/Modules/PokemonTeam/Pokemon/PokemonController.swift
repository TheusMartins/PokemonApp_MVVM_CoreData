//
//  PokemonController.swift
//  Pokemon app
//
//  Created by Matheus Martins on 11/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
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
        customView.setupInfos(with: viewModel.getPokemonInfos())
    }
    
    init(model: PokemonModel) {
        self.viewModel = PokemonViewModel(pokemon: model)
        super.init(nibName: nil, bundle: nil)
        customView.trashButton.addTarget(self, action: #selector(removePokemonFromTeam), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func removePokemonFromTeam() {
        let alert = UIAlertController(title: "Remove \(viewModel.getPokemonName()) from your team?", message: nil, preferredStyle: .alert)
        let removePokemonAction = UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
            self?.showFeedbackModal()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(removePokemonAction)
        alert.addAction(cancelAction)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    @objc private func showFeedbackModal() {
        viewModel.removePokemonFromTeam { [weak self] feedbackMessage in
            let alert = UIAlertController(title: feedbackMessage, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateLocalPokemons"), object: nil)
            }
            alert.addAction(alertAction)
            self?.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
