//
//  CircleButtonAnmiationView.swift
//  Crypto
//
//  Created by 黃騰威 on 4/14/25.
//

import SwiftUI

struct CircleButtonAnmiationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 3.0)
            .scaleEffect(animate ? 1.8 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation( animate ? Animation.easeOut(duration: 1.5) :
                            nil, value: animate)
    }
}

#Preview {
    CircleButtonAnmiationView(animate: .constant(false))
}
