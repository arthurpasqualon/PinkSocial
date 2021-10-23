//
//  Extensions.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
