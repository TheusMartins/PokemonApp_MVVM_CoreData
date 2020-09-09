//
//  PokemonListCell.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

class PokemonListCell: UITableViewCell {
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
    
    private let nationalDexNumber: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = UIColor(white: 1.0, alpha: 0.5)
        return label
    }()
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonListCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [pokemonImage, pokemonName, nationalDexNumber])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //pokemonImage
            pokemonImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            pokemonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pokemonImage.trailingAnchor.constraint(equalTo: pokemonName.leadingAnchor, constant: -16),
            pokemonImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            pokemonImage.heightAnchor.constraint(equalToConstant: 52),
            pokemonImage.widthAnchor.constraint(equalToConstant: 52),
    
            //pokemonName
            pokemonName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            pokemonName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pokemonName.bottomAnchor.constraint(equalTo: nationalDexNumber.topAnchor, constant: 2),
        
            //nationalDexNumber
            nationalDexNumber.leadingAnchor.constraint(equalTo: pokemonName.leadingAnchor),
            nationalDexNumber.trailingAnchor.constraint(equalTo: pokemonName.trailingAnchor),
            nationalDexNumber.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configureViews() {
        backgroundColor = .projectBlack
        selectionStyle = .none
    }
}

