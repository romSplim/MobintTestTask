//
//  LoadingHeaderFooterView.swift
//  MobintTestTask
//
//  Created by ramil on 18.05.2023.
//

import UIKit

final class LoadingHeaderFooterView: UITableViewHeaderFooterView {

    private var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .medium)
        spinnerView.hidesWhenStopped = true
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        return spinnerView
    }()
    
    private var loadingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подгрузка компании"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(spinnerView)
        contentView.addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            
            spinnerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            spinnerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            loadingLabel.topAnchor.constraint(equalTo: spinnerView.bottomAnchor, constant: 10),
            loadingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
        ])
    }
}
