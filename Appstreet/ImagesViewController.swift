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

            case let .failure(error):
                print("Error while fetching photos - \(error)")
            }
        }
    }
}

