//
//  PokemonListCell.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
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
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfos(with pokemon: Pokemon, pokemonIndex: Int) {
        pokemonImage.image = nil
        pokemonName.text = pokemon.name.capitalized
        pokemonImage.showLoading()
    }
    
    func setupImage(image: UIImage, hasError: Bool) {
        if hasError { pokemonImage.tintColor = .white }
        pokemonImage.hideLoading()
        pokemonImage.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImage.hideLoading()
        pokemonImage.image = nil
    }
}

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

