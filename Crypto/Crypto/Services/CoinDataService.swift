//
//  CoinDataService.swift
//  Crypto
//
//  Created by 黃騰威 on 4/15/25.
//

import Foundation


@MainActor
class CoinDataService {

    @Published var allCoins: [CoinModel] = []
    
    static let shared = CoinDataService()

    init() {
        
    }

    func getCoins() async {
        guard
            let url = URL(
                string:
                    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
            )
        else {
            print("Invalid URL (CoinDataService/getCoins)")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode)
            else {
                throw URLError(.badServerResponse)
            }
            let decodedModels = try JSONDecoder().decode(
                [CoinModel].self, from: data)
            allCoins = decodedModels
        } catch {
            print("Error downloading data: \(error)")
        }

    }
}
