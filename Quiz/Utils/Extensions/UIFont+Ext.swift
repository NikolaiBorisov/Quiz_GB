//
//  UIFont+Ext.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

extension UIFont {
    
    static var buttonFont25: UIFont {
        return UIFont(name: "Avenir Next Medium", size: 25) ?? UIFont.systemFont(ofSize: 25)
    }
    
    static var labelFont20: UIFont {
        return UIFont(name: "Avenir Next Medium", size: 20) ?? UIFont.systemFont(ofSize: 20)
    }
    
}
