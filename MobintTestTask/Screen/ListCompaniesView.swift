//
//  ViewController.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import UIKit

protocol ListCompaniesViewProtocol: AnyObject {
    func reloadTable()
    func showLoadingProcess()
    func stopLoadingProcess()
    func presentAlert(_ message: String)
}

private enum Constants {
    static let screenTitle = "Управление картами"
}

final class ListCompaniesView: UIViewController {
    
    //MARK: - Properties
    var presenter: ListCompaniesPresenter?
    
    //MARK: - Private properties
    private var tableFooterView = LoadingHeaderFooterView()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        tableView.register(LoadingHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "reusable")
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
        setupNavbar()
        view.backgroundColor = .systemGroupedBackground
        presenter?.loadInitialCompanies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableFooterView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: tableView.frame.width,
                                       height: 50)
    }
    
    //MARK: - Private methods
    private func setupNavbar() {
        self.title = Constants.screenTitle
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.foregroundColor : UIColor.systemBlue]
            appearance.backgroundColor = .white
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.standardAppearance = appearance
        }
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

//MARK: - UITableViewDelegate
extension ListCompaniesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.triggerPaginationLoading(by: indexPath)
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
    func showLoadingProcess() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView = self.tableFooterView
        }
    }
    
    func presentAlert(_ message: String) {
        DispatchQueue.main.async {
            self.popupAlert(message: message)
        }
    }
    
    func stopLoadingProcess() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView = nil
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - CardCellDelegate
extension ListCompaniesView: CardCellDelegate {
    func didTappedButton(_ buttonType: CardCell.ButtonType) {
        guard let buttonName = presenter?.getButtonName(from: buttonType) else { return }
        popupAlert(message: "Вы нажали кнопку - \(buttonName)")
    }
}



