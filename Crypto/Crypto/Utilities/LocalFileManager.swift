//
//  LocalFileManager.swift
//  Crypto
//
//  Created by 黃騰威 on 4/16/25.
//

import Foundation
import SwiftUI

//MARK: Note: this swift is using for storing image download from Website

/*
 Short-term: .cacheDirectory (auto deleted)
 Long-term: .documentDirectory (persist - visible data)
 Long-term: .applicationSupport (persist - invisible data)
 */

class LocalFileManager {

    static let instance = LocalFileManager()

    private init() {}

    func saveImageAPI(image: UIImage, imageName: String, folderName: String) {

        // create folder
        createFolderIfNeeded(folderName: folderName)

        // get path for image
        guard
            let data = image.pngData(),
            let url = getURLImage(imageName: imageName, folderName: folderName)
        else { return }

        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("error saving image. \(error)")
        }
    }

    func getImageAPI(imageName: String, folderName: String) -> UIImage? {

        guard
            let url = getURLImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path())
        else { return nil }
        return UIImage(contentsOfFile: url.path())
    }

    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLFolder(folderName: folderName) else { return }
        // if folder not exist
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(
                    at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print(
                    "error creating directory. FolderName: \(folderName). \(error)"
                )
            }
        }
    }

    private func getURLFolder(folderName: String) -> URL? {
        guard
            let url = FileManager.default.urls( // i use .cache, if for long-term change to .documentDirectory (visible) or .applicationSupoort (invisible)
                for: .cachesDirectory, in: .userDomainMask
            ).first
        else { return nil }
        return url.appendingPathComponent(folderName)
    }

    private func getURLImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
