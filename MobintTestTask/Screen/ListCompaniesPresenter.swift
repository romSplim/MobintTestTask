//
//  ListCompaniesPresenter.swift
//  MobintTestTask
//
//  Created by ramil on 10.05.2023.
//

import UIKit

protocol ListCompaniesPresenterProtocol {
    
}

final class ListCompaniesPresenter: ListCompaniesPresenterProtocol {
    //MARK: - Properties
    private(set) weak var view: ListCompaniesViewProtocol?
    
    //MARK: - Private properties
    private(set) var networkFetcher: NetworkFetcherProtocol
    private(set) var imageService: ImageServiceProtocol
    
    private(set) var companies: [CompanyCard]?
    private var isDataLoading = false
    private var isNeededToLoadNextCompanies = true
    
    private var offset: Int {
        return companies?.count ?? 0
    }
   
    //MARK: - Init
    init(view: ListCompaniesViewProtocol,
         networkFetcher: NetworkFetcherProtocol = NetworkFetcher.shared,
         imageService: ImageServiceProtocol) {
        
        self.view = view
        self.networkFetcher = networkFetcher
        self.imageService = imageService
    }
    
    //MARK: - Methods
    func getCompaniesCount() -> Int {
        return companies?.count ?? 0
    }
    
    func getCompanyForRow(indexPath: IndexPath) -> CompanyCard? {
        return companies?[indexPath.row]
    }
    
    func loadImage(url: String,
                   indexPath: IndexPath,
                   completion: @escaping (UIImage?) -> Void) {
        
        imageService.loadImage(url: url, indexPath: indexPath, completion: completion)
    }
    
    func loadInitialCompanies() {
        networkFetcher.fetchCompanies(endPoint: .getAllCompanies(offset: offset)) { result in
            switch result {
            case .success(let success):
                self.companies = success
                DispatchQueue.main.async {
                    self.view?.reloadTable()
                }
            case .failure(let failure):
                self.view?.presentAlert(failure.message)
            }
        }
    }
    
    func loadNextCompanies() {
        guard !isDataLoading && isNeededToLoadNextCompanies else { return }
        isDataLoading = true
    
        networkFetcher.fetchCompanies(endPoint: .getAllCompanies(offset: offset)) { result in
            
            defer { self.isDataLoading = false }
            
            switch result {
            case .success(let newCompanies):
                if !newCompanies.isEmpty {
                    self.companies?.append(contentsOf: newCompanies)
                    self.view?.reloadTable()
                } else {
                    self.isNeededToLoadNextCompanies = false
                    self.view?.stopLoadingProcess()
                }
                
            case .failure(let failure):
                self.view?.presentAlert(failure.message)
            }
        }
    }
    
    func triggerPaginationLoading(by indexPath: IndexPath) {
        let lastElement = offset - 1
        if indexPath.row == lastElement {
            loadNextCompanies()
            self.view?.showLoadingProcess()
        }
    }
    
    func getButtonName(from buttonType: CardCell.ButtonType) -> String {
        switch buttonType {
        case .sight, .trash, .more:
            return buttonType.name
        }
    }
}
