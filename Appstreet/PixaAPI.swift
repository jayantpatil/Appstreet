//
//  PixaAPI.swift
//  Appstreet
//
//  Created by Jayant on 22/07/20.
//  Copyright © 2020 Jayant. All rights reserved.
//

import Foundation

enum Endpoint: String {
    case searchImages = ""
}

struct PixaResponse: Codable {
    let images: [Image]

    enum CodingKeys: String, CodingKey {
        case images = "hits"
    }
}

struct PixaAPI {
    private static let baseURLString = "https://pixabay.com/api/"
    private static let key = "17577339-d40adde472bf1bd9e8a4ad81e"


    static var searchImagesURL: URL {
        return pixaURL(endpoint: .searchImages, parameters: ["key": key, "q": "computer", "image_type": "photo"])
    }

    private static func pixaURL(endpoint: Endpoint, parameters: [String: String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        if let otherParams = parameters {
            for (name, value) in otherParams {
                let item = URLQueryItem(name: name, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
    }
}
