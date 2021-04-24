//
//  d.swift
//  GridAssignment
//
//  Created by Bhushan on 24/04/21.
//

import UIKit

enum FontBook: String {
    case Book = "Avenir-Book"
    case Medium = "Avenir-Medium"
    case Heavy = "Avenir-Heavy"
    case Black = "Avenir-Black"
    
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
