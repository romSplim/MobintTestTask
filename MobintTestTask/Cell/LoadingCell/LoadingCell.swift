//
//  LoadingCell.swift
//  MobintTestTask
//
//  Created by ramil on 18.05.2023.
//

import UIKit

final class LoadingCell: UITableViewCell {

    private var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .medium)
        spinnerView.hidesWhenStopped = true
        return spinnerView
    }()
    
    private var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Подгрузка компании"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoadingProcess() {
        spinnerView.startAnimating()
    }
    
    func hideLoadingProcess() {
        spinnerView.stopAnimating()
    }
    
    private func setupSubviews() {
        NSLayoutConstraint.activate([
            
            spinnerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            spinnerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            loadingLabel.topAnchor.constraint(equalTo: spinnerView.bottomAnchor, constant: 10),
            loadingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
        ])
    }
}
