//
//  MockListCompaniesView.swift
//  MobintTests
//
//  Created by ramil on 21.05.2023.
//

import UIKit
@testable import MobintTestTask

class MockListCompaniesView: ListCompaniesViewProtocol {
    
    //MARK: - Testable properties
    var expectedMessage = String()
    var reloadTableExecutionCount = 0
    var showLoadingProcessExecutionCount = 0
    var stopLoadingProcessExecutionCount = 0
    var presentAlertExecutionCount = 0
    
    //MARK: - Testable methods
    func reloadTable() {
        reloadTableExecutionCount += 1
    }
    
    func showLoadingProcess() {
        showLoadingProcessExecutionCount += 1
    }
    
    func stopLoadingProcess() {
        stopLoadingProcessExecutionCount += 1
    }
    
    func presentAlert(_ message: String) {
        expectedMessage = message
        presentAlertExecutionCount += 1
    }
}
