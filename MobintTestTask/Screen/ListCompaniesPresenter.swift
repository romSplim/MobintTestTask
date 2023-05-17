//
//  ListCompaniesPresenter.swift
//  MobintTestTask
//
//  Created by ramil on 10.05.2023.
//

import UIKit

final class ListCompaniesPresenter {
    
    weak var view: ListCompaniesViewProtocol?
    var networkFetcher: NetworkFetcher
    var imageService: ImageService
    
    private var companies: [CompanyCard]?
    
    init(
        view: ListCompaniesViewProtocol,
        networkFetcher: NetworkFetcher = NetworkFetcher.shared,
        imageService: ImageService
    ) {
        self.view = view
        self.networkFetcher = networkFetcher
        self.imageService = imageService
    }
    
    func getCompaniesCount() -> Int {
        return companies?.count ?? 0
    }
    
    func getCompanyForRow(indexPath: IndexPath) -> CompanyCard? {
        return companies?[indexPath.row]
    }
    
    func loadImage(url: String, indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        imageService.loadImage(url: url, indexPath: indexPath, completion: completion)
    }
    
    func getCompanies() {
        let request = APIManager.getAllCompaniesError.request()
        networkFetcher.fetchCompanies(with: request) { result in
            
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.message)
            }
        }
    }
    
    func handleButtonAction(buttonType: CardCell.ButtonType) -> String {
        switch buttonType {
        case .sight, .trash, .more:
            return buttonType.name
        }
    }
}
