//
//  ImageStore.swift
//  Appstreet
//
//  Created by Jayant on 22/07/20.
//  Copyright © 2020 Jayant. All rights reserved.
//

import Foundation

class ImageStore {
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()

    func getImages(completion: @escaping (Result<[Image], Error>) -> Void) {
        let url = PixaAPI.searchImagesURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processImagesRequest(data: data, error: error)
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
}
