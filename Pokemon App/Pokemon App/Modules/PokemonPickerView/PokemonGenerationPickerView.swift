//
//  PokemonGenerationPickerView.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

protocol PokemonGenerationPickerDelegate: class {
    func didClosePickerView(generationIndex: Int)
}

final class PokemonGenerationPickerView: UIView {
    private let pokemonGenerations = [
        "First generation",
        "Second generation",
        "Third generation",
        "Fourth generation",
        "Fifth generation",
        "Sixth generation",
        "Seventh generation",
        "Eighth generatino"
    ]
    
    private let picker = UIPickerView()
    
    private var generationIndex = 0
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    weak var delegate: PokemonGenerationPickerDelegate?
    
    init(delegate: PokemonGenerationPickerDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViewConfiguration()
        picker.dataSource = self
        picker.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closePickerView() {
        delegate?.didClosePickerView(generationIndex: generationIndex)
        removeFromSuperview()
    }
}

extension PokemonGenerationPickerView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [picker, closeButton])
        bringSubviewToFront(closeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            closeButton.heightAnchor.constraint(equalToConstant: 48),
            closeButton.widthAnchor.constraint(equalToConstant: 48),
            
            picker.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            picker.leadingAnchor.constraint(equalTo: leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: bottomAnchor),
            picker.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
        closeButton.addTarget(self, action: #selector(closePickerView), for: .touchUpInside)
    }
}

extension PokemonGenerationPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pokemonGenerations.count
    }
}

extension PokemonGenerationPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pokemonGenerations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        generationIndex = row
    }
}
