//
//  MockImageService.swift
//  MobintTests
//
//  Created by ramil on 22.05.2023.
//

import UIKit
@testable import MobintTestTask

class MockImageService: ImageServiceProtocol {
    
    var loadImageExecutionCount = 0
    
    func loadImage(url: String, indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        loadImageExecutionCount += 1
        completion(nil)
    }
}
