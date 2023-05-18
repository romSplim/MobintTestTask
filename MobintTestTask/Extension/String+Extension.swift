//
//  String+Extension.swift
//  MobintTestTask
//
//  Created by ramil on 12.05.2023.
//

import Foundation

extension String {
    static func getRightWordEnding(for points: Int) -> String? {
        var word = String()
        
        if (points % 10 == 1 && points % 100 != 11) {
            
            word = "балл"
            
        } else if ((points % 10 >= 2 && points % 10 <= 4)
                   &&
                   !(points % 100 >= 12 && points % 100 <= 14)) {
            
            word = "балла"
            
        } else if (points % 10 == 0
                   ||
                   (points % 10 >= 5 && points % 10 <= 9)
                   ||
                   (points % 100 >= 11 && points % 100 <= 14)) {
            
            word = "баллов"
        }
        return word
    }
}
