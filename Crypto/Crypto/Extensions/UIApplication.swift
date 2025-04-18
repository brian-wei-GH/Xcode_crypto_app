//
//  UIApplication.swift
//  Crypto
//
//  Created by 黃騰威 on 4/16/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
