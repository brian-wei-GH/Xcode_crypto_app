//
//  CryptoApp.swift
//  Crypto
//
//  Created by 黃騰威 on 4/14/25.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
