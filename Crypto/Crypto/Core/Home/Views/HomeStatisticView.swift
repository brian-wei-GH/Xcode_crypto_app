//
//  StatisticView.swift
//  Crypto
//
//  Created by 黃騰威 on 4/16/25.
//

import SwiftUI

struct HomeStatisticView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showProfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showProfolio ? .trailing : .leading)
    }
}

#Preview {
    let dev = DeveloperPreview.instance
    HomeStatisticView(showProfolio: .constant(false))
        .environmentObject(dev.homeVM)
}
