//
//  CoinRowView.swift
//  Crypto
//
//  Created by 黃騰威 on 4/15/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHouldingColumn: Bool
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if showHouldingColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview {
    let dev = DeveloperPreview.instance
    CoinRowView(coin: dev.coin, showHouldingColumn: true)
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            
            if let percentChange = coin.priceChangePercentage24H {
                Text(percentChange.asPercentString())
                    .foregroundStyle(percentChange >= 0 ? Color.theme.green : Color.theme.red)
            } else {
                Text("N/A")
                    .foregroundStyle(Color.gray)
            }
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }

}
