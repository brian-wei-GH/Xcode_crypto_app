//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by 黃騰威 on 4/15/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class CoinImageViewModel: ObservableObject {

    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false

    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.dataService = CoinImageService(coin: coin)
        fetchImage()
    }

    private func fetchImage() {
        isLoading = true
        dataService.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedImage in
                self?.image = returnedImage
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}
