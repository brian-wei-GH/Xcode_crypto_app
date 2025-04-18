//
//  CoinImageService.swift
//  Crypto
//
//  Created by 黃騰威 on 4/15/25.
//

import Foundation
import SwiftUI

@MainActor
class CoinImageService: ObservableObject {

    @Published var image: UIImage? = nil
    
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"

    init(coin: CoinModel) {
        self.coin = coin
        Task {
            await getCoinImage()
        }
    }
    
    private func getCoinImage() async {
        if let saveImage = fileManager.getImageAPI(imageName: coin.id, folderName: folderName) {
            self.image = saveImage
            // debug code
            print("get image from FileManager")
        } else {
            await downloadCoinImage(urlString: coin.image)
        }
    }

    func downloadCoinImage(urlString: String) async {
        guard
            let url = URL(string: urlString)
        else {
            print("Invalid URL (CoinImageService/getCoinImage)")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode)
            else {
                throw URLError(.badServerResponse)
            }

            if let downloadedImage = UIImage(data: data) {
                self.image = downloadedImage
                // debug code
                print("download image from api")
                fileManager.saveImageAPI(image: downloadedImage, imageName: coin.id, folderName: folderName)
            } else {
                print("Error: Failed to convert data to UIImage")
            }
        } catch {
            print("Error downloading image: \(error)")
        }
    }
}
