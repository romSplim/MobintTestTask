//
//  UIView+Extension.swift
//  MobintTestTask
//
//  Created by ramil on 11.05.2023.
//

import UIKit

extension UIView {
    static func createSeparator(with color: UIColor = .gray) -> UIView {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = color
        return separator
    }
}
