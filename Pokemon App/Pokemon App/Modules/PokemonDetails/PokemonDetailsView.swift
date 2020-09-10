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
    
    private let imagesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    private let frontImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.layer.cornerRadius = 26
        image.clipsToBounds = true
        return image
    }()
    
    private let backImage: UIImageView = {
        let image = UIImageView(frame: .zero)
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
    
    private let addPokemonButton: UIButton = {
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
        DispatchQueue.main.async {
            self.nationalDexIdLabel.text = "National dex id: \(model.id)"
            self.pokemonTypesLabel.text = "Type: "
            for type in model.types {
                self.pokemonTypesLabel.text! += type.type.name.capitalized + " "
            }
            
            DownloadImage.shared.getPokemonImage(url: model.sprites.front) { image, error in
                DispatchQueue.main.async {
                    self.frontImage.image = image
                }
            }
            
            DownloadImage.shared.getPokemonImage(url: model.sprites.back) { image, error in
                DispatchQueue.main.async {
                    self.backImage.image = image
                }
            }
        }
        
    }
}

extension PokemonDetailsView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [
            imagesStackView,
            pokemonInfosStack,
            addPokemonButton
        ])
        imagesStackView.addArrangedSubviews(views: [frontImage, backImage])
        pokemonInfosStack.addArrangedSubviews(views: [nationalDexIdLabel, pokemonTypesLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imagesStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            imagesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            imagesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            imagesStackView.heightAnchor.constraint(equalToConstant: 150),
        
            pokemonInfosStack.topAnchor.constraint(equalTo: imagesStackView.bottomAnchor, constant: 24),
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
