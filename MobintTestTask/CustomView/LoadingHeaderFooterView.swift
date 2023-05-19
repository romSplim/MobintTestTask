//
//  LoadingHeaderFooterView.swift
//  MobintTestTask
//
//  Created by ramil on 18.05.2023.
//

import UIKit

fileprivate enum Constants {
    static let loadingLabelText = "Подгрузка компаний"
}

final class LoadingHeaderFooterView: UITableViewHeaderFooterView {
    
    //MARK: - Provate properties
    private var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .medium)
        spinnerView.startAnimating()
        spinnerView.hidesWhenStopped = true
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        return spinnerView
    }()
    
    private var loadingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.loadingLabelText
        return label
    }()
    
    //MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func showLoadingProcess() {
        spinnerView.startAnimating()
    }
    
    func hideLoadingProcess() {
        spinnerView.stopAnimating()
    }
    
    //MARK: - Private methods
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
