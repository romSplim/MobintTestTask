//
//  TitleView.swift
//  MobintTestTask
//
//  Created by ramil on 10.05.2023.
//

import UIKit

final class TitleView: UIStackView {

    //MARK: - Properties
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = Font.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var logoImage: UIImageView = {
        var imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImage.layer.cornerRadius = logoImage.bounds.height / 2
    }
    
    //MARK: - Methods
    func setCompanyName(_ text: String) {
        titleLabel.text = text
    }
    
    func setCompanyLogo(_ image: UIImage) {
        logoImage.image = image
    }
    
    //MARK: - Private methods
    private func setupSubviews() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(logoImage)
        
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 40),
            logoImage.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
