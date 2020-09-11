//
//  PokemonDetailsView.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class PokemonDetailsView: UIView {
    
    private let pokemonInfosStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 16
        return stack
    }()
    
    private let imageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    private let frontImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 26
        image.clipsToBounds = true
        return image
    }()
    
    private let nationalDexIdLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.textColor = .white
        return label
    }()
    
    private let pokemonTypesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.textColor = .white
        return label
    }()
    
    let addPokemonButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primaryColor
        button.layer.cornerRadius = 8
        button.setTitle("Add in your Team", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfos(with model: PokemonDetailsModel) {
        DispatchQueue.main.async { [weak self] in
            self?.nationalDexIdLabel.text = "National dex id: \(model.id)"
            self?.pokemonTypesLabel.text = "Type: "
            for type in model.types {
                self?.pokemonTypesLabel.text! += type.type.name.capitalized + " "
            }
            self?.frontImage.showLoading()
        }
    }
    
    func setupImages(front: UIImage, hasError: Bool) {
        DispatchQueue.main.async { [weak self] in
            if hasError { self?.frontImage.tintColor = .white }
            self?.frontImage.hideLoading()
            self?.frontImage.image = front
        }
    }
}

extension PokemonDetailsView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [
            imageStackView,
            pokemonInfosStack,
            addPokemonButton
        ])
        imageStackView.addArrangedSubviews(views: [frontImage])
        pokemonInfosStack.addArrangedSubviews(views: [nationalDexIdLabel, pokemonTypesLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            imageStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            imageStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            imageStackView.heightAnchor.constraint(equalToConstant: 150),
        
            pokemonInfosStack.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 24),
            pokemonInfosStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            pokemonInfosStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            pokemonInfosStack.bottomAnchor.constraint(lessThanOrEqualTo: addPokemonButton.topAnchor),

            addPokemonButton.heightAnchor.constraint(equalToConstant: 40),
            addPokemonButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            addPokemonButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            addPokemonButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    func configureViews() {
        backgroundColor = .projectBlack
    }
}
