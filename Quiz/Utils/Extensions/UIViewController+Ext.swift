//
//  UIViewController+Ext.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 06.08.2021.
//

import UIKit

extension UIViewController {
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        return UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
    }
    
    func setupHideKeyboardOntaps() {
        view.addGestureRecognizer(self.endEditingRecognizer())
        navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
}
