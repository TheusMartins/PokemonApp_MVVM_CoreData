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
        pokemonName.text = pokemon.name
        pokemonImage.showLoading()
        DownloadImage.shared.getPokemonImage(id: "\(pokemonIndex + 1)") { image, _ in
            DispatchQueue.main.async {
                self.pokemonImage.hideLoading()
                self.pokemonImage.image = image
            }
        }
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

