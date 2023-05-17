//
//  ViewController.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import UIKit

protocol ListCompaniesViewProtocol: AnyObject {
    func reloadTable()
}

final class ListCompaniesView: UIViewController {
    
    var presenter: ListCompaniesPresenter?
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        setupSubviews()
        view.backgroundColor = .systemGroupedBackground
        presenter?.getCompanies()
        print(CardCell.identifier)
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ListCompaniesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension ListCompaniesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCompaniesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell,
              let company = presenter?.getCompanyForRow(indexPath: indexPath)  else { return UITableViewCell() }
        cell.delegate = self
        cell.configure(with: company)
        presenter?.loadImage(url: company.mobileAppDashboard.logo, indexPath: indexPath) { image in
            cell.setCompanyLogo(image ?? UIImage())
        }
        return cell
    }
}

extension ListCompaniesView: ListCompaniesViewProtocol {
    func reloadTable() {
        tableView.reloadData()
    }
}

extension ListCompaniesView: CardCellDelegate {
    func didTappedButton(_ buttonType: CardCell.ButtonType) {
        let alertMessage = presenter?.handleButtonAction(buttonType: buttonType)
        print(alertMessage)
    }
}
