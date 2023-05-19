//
//  UIViewController+Extension.swift
//  MobintTestTask
//
//  Created by ramil on 18.05.2023.
//

import UIKit

extension UIViewController {
    func popupAlert(title: String = "Alert",
                    message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
