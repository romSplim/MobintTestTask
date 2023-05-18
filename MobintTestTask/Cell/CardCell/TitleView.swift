//
//  TitleView.swift
//  MobintTestTask
//
//  Created by ramil on 10.05.2023.
//

import UIKit

final class TitleView: UIStackView {

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = Font.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var logoImage: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImage.layer.cornerRadius = logoImage.bounds.height / 2
    }
    
    func setCompanyName(_ text: String) {
        titleLabel.text = text
    }
    
    func setCompanyLogo(_ image: UIImage) {
        logoImage.image = image
    }
    
    private func setupSubviews() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(logoImage)
        
        logoImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
