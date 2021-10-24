//
//  NasaImageViewController.swift
//  NasaProject
//
//  Created by Чистяков Василий Александрович on 07.10.2021.
//

import UIKit

class NasaImageViewController: UIViewController {
    
    var networkFetchService: NetworkFetchService!
    var imageSave: UIImage?
    
    @IBOutlet weak var imageNasaVc: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkFetchService = NetworkFetchService()
        networkFetchService.fetchDataNasaImage { model in
            DispatchQueue.main.async {
                guard let imageData = model?.hdurl else { return }
                self.networkFetchService.fecthImage(urlString: imageData) { image in
                    self.imageSave = image
                    self.imageNasaVc.image = image
                }
            }
        }
    }
    
    @IBAction func saveImage(_ sender: Any) {
        
        guard let imageSave = imageSave else { return }
        
        let allertController = UIAlertController(title: "Сохранение", message: "Сохранить фото в галерею?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in self.navigationController?.popToRootViewController(animated: true)}
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in UIImageWriteToSavedPhotosAlbum(imageSave, nil, nil, nil) }
        
        allertController.addAction(cancelAction)
        allertController.addAction(okAction)
        
        present(allertController, animated: true, completion: nil)
    }
}

