//
//  HomeView.swift
//  Crypto
//
//  Created by 黃騰威 on 4/14/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background.ignoresSafeArea()
            
            // content layer
            VStack {
                /// extension HomeView
                homeHeader
                    .padding()
                HomeStatisticView(showProfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                }
                
                if showPortfolio {
                    portfolioCoinList
                }
                
                Spacer()
                
            }
        }
    }
}


#Preview {
    let dev = DeveloperPreview.instance
    HomeView()
        .environmentObject(dev.homeVM)
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(nil, value: showPortfolio)
                .background(
                    CircleButtonAnmiationView(animate: $showPortfolio)
                )
            
            Spacer()
            Text(showPortfolio ? "Profolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .animation(nil, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHouldingColumn: false)
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .leading))
    }
    
    private var portfolioCoinList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHouldingColumn: true)
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .trailing))
        
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
