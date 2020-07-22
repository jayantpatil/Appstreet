//
//  Image.swift
//  Appstreet
//
//  Created by Jayant on 22/07/20.
//  Copyright © 2020 Jayant. All rights reserved.
//

import Foundation

class Image: Codable {
    // Actual response object contains many other parameters. Here processing only which are necessary.
    let id: Int
    let previewURL: URL?
    let webformatURL: URL?
    let largeImageURL: URL?
    let imageURL: URL?
}
