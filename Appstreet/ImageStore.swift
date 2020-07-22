//
//  ImageStore.swift
//  Appstreet
//
//  Created by Jayant on 22/07/20.
//  Copyright © 2020 Jayant. All rights reserved.
//

import UIKit

enum ImageError: Error {
    case imageCreationError
    case missingImageURL
}

class ImageStore {
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()

    func getImages(completion: @escaping (Result<[Image], Error>) -> Void) {
        let url = PixaAPI.searchImagesURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, _, error) in
            let result = self.processImagesRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }

    func getImage(for image: Image, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let imageURL = image.previewURL else {
            completion(.failure(ImageError.missingImageURL))
            return
        }

        let request = URLRequest(url: imageURL)
        let task = session.dataTask(with: request) { (data, _, error) in
            let result = self.processImageRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }

    private func processImagesRequest(data: Data?, error: Error?) -> Result<[Image], Error> {
        guard let data = data else {
            return .failure(error!)
        }

        return PixaAPI.extractImages(fromJSON: data)
    }

    private func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
        guard let imageData = data,
            let image = UIImage(data: imageData) else {
                // Couldn't create an image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(ImageError.imageCreationError)
                }
        }
        return .success(image)
    }
}
