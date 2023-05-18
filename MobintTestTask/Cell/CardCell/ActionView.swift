//
//  ActionView.swift
//  MobintTestTask
//
//  Created by ramil on 10.05.2023.
//

import UIKit

fileprivate enum Constants {
    static let tinyButtonScale: CGFloat = 0.8
    static let tinyButtonSize: CGSize = .init(width: 25, height: 25)
    static let moreButtonSize: CGSize = .init(width: 120, height: 40)
    static let moreButtonTitle = "Подробнее"
}

final class ActionView: UIStackView {
    
    var onButtonTap: (UIButton) -> () = {_ in }
    
    private lazy var sightButton: UIButton = {
        let button = UIButton()
        let eyeIcon = UIImage(named: AssetName.eyeImage)?
            .withTintColor(.systemBlue)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.tag = 1
        button.transform = .init(scaleX: Constants.tinyButtonScale, y: Constants.tinyButtonScale)
        button.setImage(eyeIcon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var trashButton: UIButton = {
        let button = UIButton()
        let trashIcon = UIImage(named: AssetName.trashImage)?.withTintColor(.red)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.tag = 2
        button.transform = .init(scaleX: Constants.tinyButtonScale, y: Constants.tinyButtonScale)
        button.setImage(trashIcon, for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.tag = 3
        button.layer.cornerRadius = 15
        button.setTitle(Constants.moreButtonTitle, for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
        alignment = .center
        setCustomSpacing(Layout.blueSpacing, after: sightButton)
        setCustomSpacing(Layout.blueSpacing, after: trashButton)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        onButtonTap(sender)
    }
    
    private func setupSubviews() {
        addArrangedSubview(sightButton)
        addArrangedSubview(trashButton)
        addArrangedSubview(moreButton)
        
        NSLayoutConstraint.activate([
            sightButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.redSpacing),
            sightButton.heightAnchor.constraint(equalToConstant: Constants.tinyButtonSize.height),
            sightButton.widthAnchor.constraint(equalToConstant: Constants.tinyButtonSize.width),
            
            trashButton.heightAnchor.constraint(equalToConstant: Constants.tinyButtonSize.height),
            trashButton.widthAnchor.constraint(equalToConstant: Constants.tinyButtonSize.width),
            
            moreButton.heightAnchor.constraint(equalToConstant: Constants.moreButtonSize.height),
            moreButton.widthAnchor.constraint(equalToConstant: Constants.moreButtonSize.width)
        ])
    }
}
