//
//  ViewController.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import UIKit

protocol ListCompaniesViewProtocol: AnyObject {
    func reloadTable()
    func stopLoadingProcess()
}

final class ListCompaniesView: UIViewController {
    //MARK: - Properties
    var presenter: ListCompaniesPresenter?
    var tableFooterView = LoadingHeaderFooterView()
    
    //MARK: - Private properties
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        tableView.register(LoadingHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "reusable")
        tableView.tableFooterView = tableFooterView
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        view.backgroundColor = .systemGroupedBackground
        presenter?.loadInitialCompanies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableFooterView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
    }
    
    //MARK: - Private methods
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

//MARK: - UITableViewDelegate
extension ListCompaniesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let visibleHeight = scrollView.bounds.height
        let scrollOffset = scrollView.contentOffset.y
        let currentPosition = scrollOffset + visibleHeight
        
        if currentPosition >= contentHeight {
            presenter?.loadNextCompanies()
            tableFooterView.showLoadingProcess()
        }
    }
}

//MARK: - UITableViewDataSource
extension ListCompaniesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCompaniesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

//MARK: - ListCompaniesViewProtocol
extension ListCompaniesView: ListCompaniesViewProtocol {
    func stopLoadingProcess() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView = nil
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("github")
        }
    }
}

//MARK: - CardCellDelegate
extension ListCompaniesView: CardCellDelegate {
    func didTappedButton(_ buttonType: CardCell.ButtonType) {
        guard let alertMessage = presenter?.getButtonName(from: buttonType) else { return }
        popupAlert(title: "Alert", message: "Вы нажали кнопку - \(alertMessage)")
    }
}



