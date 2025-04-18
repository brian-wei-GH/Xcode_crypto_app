//
//  HowViewModel.swift
//  Crypto
//
//  Created by 黃騰威 on 4/15/25.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    //MARK: Fake data. change it later
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "title", value: "value", percenatageChange: 1),
        StatisticModel(title: "title", value: "value", percenatageChange: nil),
        StatisticModel(title: "title", value: "value", percenatageChange: -1),
        StatisticModel(title: "title", value: "value", percenatageChange: -1),
    ]

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()

    let dataService = CoinDataService.shared
    
    init() {
        Task {
            await self.fetchData()
            self.addSubscribers()
        }
    }
    
    // Loading all data (when open app)
    func fetchData() async {
        await dataService.getCoins()

        allCoins = dataService.allCoins
    }
    
    // Filter data
    func addSubscribers() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .combineLatest(dataService.$allCoins)
            .map { (text, startingCoins) -> [CoinModel] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                let lowercasedText = text.lowercased()
                return startingCoins.filter { coin in
                    coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }
            .store(in: &cancellables)
    }

}
