//
//  ModuleBuilder.swift
//  MobintTestTask
//
//  Created by ramil on 12.05.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    func buildListCompaniesModule() -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    //MARK: - Methods
    func buildListCompaniesModule() -> UIViewController {
        let controller = ListCompaniesView()
        let imageService = ImageService()
        let presenter = ListCompaniesPresenter(view: controller, imageService: imageService)
        controller.presenter = presenter
        return controller
    }
}
