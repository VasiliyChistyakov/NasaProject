//
//  NasaImageViewController.swift
//  NasaProject
//
//  Created by Чистяков Василий Александрович on 07.10.2021.
//

import UIKit

class NasaImageViewController: UIViewController {
    
    var networkFetchService = NetworkFetchService()
    
    @IBOutlet weak var imageNasaVc: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkFetchService.fetchDataNasaImage { model in
            DispatchQueue.main.async {
                guard let imageData = model?.hdurl else { return }
                self.networkFetchService.fecthImage(urlString: imageData) { image in
                    self.imageNasaVc.image = image
                }
            }
        }
//        NetworkingManager.shared.fetchDataNasaImage(url: jsonNasa) { model in
//            DispatchQueue.main.async {
//                NetworkingManager.shared.fetchImageNasa(url: model.hdurl) { image in
//                    self.imageNasaVc.image = image
//                }
//            }
//        }
    }
}

