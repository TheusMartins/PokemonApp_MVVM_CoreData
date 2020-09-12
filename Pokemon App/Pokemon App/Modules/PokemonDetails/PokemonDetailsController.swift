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
        loadPokemonInfos()
        customView.addPokemonButton.addTarget(self, action: #selector(addPokemon), for: .touchUpInside)
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
    
    private func loadPokemonInfos() {
        customView.setLoading(isLoading: true)
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.getPokemon { [weak self] model in
                guard let model = model else {
                    self?.showErrorModal()
                    return
                }
                self?.customView.setupInfos(with: model)
                self?.getPokemonImage()
                self?.customView.setLoading(isLoading: false)
            }
        }
    }
    
    private func getPokemonImage() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.getPokemonImage { [weak self] image, hasErrors in
                self?.customView.setupImages(front: image, hasError: hasErrors)
            }
        }
    }
    
    private func showErrorModal() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Could not load pokemon =(", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Try again", style: .cancel) { [weak self] _ in
                self?.loadPokemonInfos()
            }
            alert.addAction(alertAction)
            self?.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func addPokemon() {
        viewModel.addPokemon { [weak self] feedbackMessage in
            let alert = UIAlertController(title: feedbackMessage, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
