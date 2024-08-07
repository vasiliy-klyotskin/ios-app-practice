//
//  DetailPokemonInfoCell.swift
//  Pokepedia-iOS
//
//  Created by Vasiliy Klyotskin on 7/27/23.
//

import UIKit
import Pokepedia

public final class DetailPokemonInfoCell: UITableViewCell {
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genusLabel: UILabel!
    @IBOutlet var flavorLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var reloadButton: UIButton!
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet private var content: UIView!
    @IBOutlet private var imageContainer: UIView!
    
    var onReload: () -> Void = {}
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadFromNib()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: DetailPokemonInfoViewModel) {
        idLabel.text = viewModel.id
        nameLabel.text = viewModel.name
        genusLabel.text = viewModel.genus
        flavorLabel.text = viewModel.flavorText
    }
    
    func display(isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func display(reload: Bool) {
        reloadButton.isHidden = !reload
    }
    
    func display(image: UIImage) {
        pokemonImageView.isHidden = false
        pokemonImageView.image = image
        UIView.animate(withDuration: 1) { [weak self] in
            self?.pokemonImageView.alpha = 1
        }
    }
    
    private func configureUI() {
        content.fit(in: contentView)
        configureActivityIndicator()
        setupFonts()
        removeSeparator()
        setupReloadButton()
    }
    
    private func setupReloadButton() {
        reloadButton.addTarget(self, action: #selector(onReloadTapped), for: .touchUpInside)
    }
    
    private func removeSeparator() {
        separatorInset = UIEdgeInsets(top: 0, left: .greatestFiniteMagnitude, bottom: 0, right: 0)
    }
    
    private func setupFonts() {
        [nameLabel, idLabel, genusLabel, flavorLabel].forEach {
            $0?.adjustsFontForContentSizeCategory = true
        }
        nameLabel.font = .standard(size: .headline, weight: .bold)
        idLabel.font = .standard(size: .headline, weight: .semibold)
        genusLabel.font = .standard(size: .title, weight: .regular)
        flavorLabel.font = .standard(size: .title, weight: .regular)
    }
    
    private func configureActivityIndicator() {
        let scale = CGAffineTransform(scaleX: 1.7, y: 1.7)
        activityIndicator.transform = scale
        activityIndicator.alpha = 0.7
    }
    
    func makeImageContainerCircular() {
        layoutIfNeeded()
        let radius: CGFloat = imageContainer.bounds.size.width / 2.0
        imageContainer.clipsToBounds = false
        imageContainer.layer.cornerRadius = radius
    }
    
    @objc private func onReloadTapped(_ sender: UIButton) {
        onReload()
    }
}
