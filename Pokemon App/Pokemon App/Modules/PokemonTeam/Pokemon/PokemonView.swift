//
//  PokemonView.swift
//  Pokemon app
//
//  Created by Scizor on 11/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class PokemonView: UIView {
    
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
    
    let trashButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icTrash")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfos(with model: DBPokemon) {
        DispatchQueue.main.async {
            self.nationalDexIdLabel.text = "\(model.id)"
            self.pokemonTypesLabel.text = "Type: "
            for type in model.type ?? [] {
                self.pokemonTypesLabel.text! += type + " "
            }
        }
    }
}

extension PokemonView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [
            trashButton,
            imagesStackView,
            pokemonInfosStack
        ])
        imagesStackView.addArrangedSubviews(views: [frontImage, backImage])
        pokemonInfosStack.addArrangedSubviews(views: [nationalDexIdLabel, pokemonTypesLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            trashButton.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            trashButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            trashButton.heightAnchor.constraint(equalToConstant: 24),
            trashButton.widthAnchor.constraint(equalToConstant: 24),
            
            imagesStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            imagesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            imagesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            imagesStackView.heightAnchor.constraint(equalToConstant: 150),
        
            pokemonInfosStack.topAnchor.constraint(equalTo: imagesStackView.bottomAnchor, constant: 24),
            pokemonInfosStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            pokemonInfosStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            pokemonInfosStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    func configureViews() {
        backgroundColor = .projectBlack
    }
}

