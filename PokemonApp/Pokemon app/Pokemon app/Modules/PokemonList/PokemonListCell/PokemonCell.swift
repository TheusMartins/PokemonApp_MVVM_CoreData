//
//  PokemonListCell.swift
//  Pokemon app
//
//  Created by Matheus Martins on 09/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    //MARK: - Private properties
    private let pokemonImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.layer.cornerRadius = 26
        image.clipsToBounds = true
        return image
    }()
    
    private let pokemonName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .white
        return label
    }()
    
    //MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    //MARK: - Public methods
    func setupInfos(with pokemon: Pokemon, pokemonIndex: Int) {
        pokemonName.text = pokemon.name.capitalized
        pokemonImage.showLoading()
        setupViewConfiguration()
    }
    
    func setupImage(image: UIImage, hasError: Bool) {
        if hasError { pokemonImage.tintColor = .white }
        pokemonImage.hideLoading()
        pokemonImage.image = image
    }
}

//MARK: - ViewConfiguration
extension PokemonCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [pokemonImage, pokemonName])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //pokemonImage
            pokemonImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            pokemonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pokemonImage.trailingAnchor.constraint(equalTo: pokemonName.leadingAnchor, constant: -16),
            pokemonImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            pokemonImage.heightAnchor.constraint(equalToConstant: 100),
            pokemonImage.widthAnchor.constraint(equalToConstant: 100),
    
            //pokemonName
            pokemonName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            pokemonName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pokemonName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    func configureViews() {
        backgroundColor = .projectBlack
        selectionStyle = .none
    }
}

