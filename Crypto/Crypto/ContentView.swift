//
//  ContentView.swift
//  Crypto
//
//  Created by 黃騰威 on 4/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                Text("accent color")
                    .foregroundStyle(Color.theme.accent)
                
                Text("secondary text color")
                    .foregroundStyle(Color.theme.secondaryText)
                
                Text("Red color")
                    .foregroundStyle(Color.theme.red)
                
                Text("green")
                    .foregroundStyle(Color.theme.green)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
