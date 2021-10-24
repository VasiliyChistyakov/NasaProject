//
//  NasaRoverSecondViewController.swift
//  NasaProject
//
//  Created by Чистяков Василий Александрович on 07.10.2021.
//

import UIKit

class NasaRoverSecondViewController: UIViewController {
    
    @IBOutlet weak var imageSecVc: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var photoGallery: Photo!
    var networkFetchService: NetworkFetchService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkFetchService  = NetworkFetchService()
        let image = photoGallery.imgSrc
        networkFetchService.fecthImage(urlString: image) { model in
            DispatchQueue.main.async {
                self.imageSecVc.image = model
                self.nameLabel.text = self.photoGallery.camera.name
                self.dataLabel.text = self.photoGallery.rover.launchDate
                self.descriptionLabel.text = self.photoGallery.camera.fullName
            }
        }
    }
}
