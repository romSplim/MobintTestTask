//
//  UIView+Extension.swift
//  MobintTestTask
//
//  Created by ramil on 11.05.2023.
//

import UIKit

extension UIView {
    func createSeparator(with color: UIColor = .gray) -> UIView {
        let separator = UIView()
        separator.backgroundColor = color
        return separator
    }
}
