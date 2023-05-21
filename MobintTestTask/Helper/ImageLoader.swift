//
//  ImageLoader.swift
//  MobintTestTask
//
//  Created by ramil on 12.05.2023.
//

import UIKit

protocol ImageServiceProtocol {
    func loadImage(url: String, indexPath: IndexPath, completion: @escaping (UIImage?) -> Void)
}

final class ImageService: ImageServiceProtocol {
    
    //MARK: - Private properties
    private let cache = NSCache<NSNumber, UIImage>()
    
    //MARK: - Methods
    func loadImage(url: String, indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: url) else { return }
        let index = NSNumber(value: indexPath.row)
        
        if let cachedImage = cache.object(forKey: index) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    guard let data,
                          let image = UIImage(data: data) else { return }
                    self.cache.setObject(image, forKey: index)
                    completion(image)
                }
            }.resume()
        }
    }
}

