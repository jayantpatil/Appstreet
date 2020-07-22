//
//  ImagesViewController.swift
//  Appstreet
//
//  Created by Jayant on 22/07/20.
//  Copyright © 2020 Jayant. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var store: ImageStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        store.getImages { response in
            switch response {
            case let .success(images):
                print("Received \(images.count) images")
                if let firstImage = images.first {
                    self.updateImageView(for: firstImage)
                }
            case let .failure(error):
                print("Error while fetching photos - \(error)")
            }
        }
    }

    func updateImageView(for image: Image) {
        store.getImage(for: image) {
            (imageResult) in
            switch imageResult {
            case let .success(image):
                self.imageView.image = image

            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
}

