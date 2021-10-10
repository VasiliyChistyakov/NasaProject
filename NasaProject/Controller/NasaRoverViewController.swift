//
//  NasaRoverViewController.swift
//  NasaProject
//
//  Created by Чистяков Василий Александрович on 07.10.2021.
//

import UIKit

class NasaRoverViewController: UIViewController {
    
    let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY"
//            let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY"
    
    let countCell = 3
    let offset:CGFloat = 2.0
    var arrayPhoto: NasaRoverModel!
    var networkFetchService = NetworkFetchService()
    
    @IBOutlet weak var NasaRovercollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NasaRovercollectionView.dataSource = self
        NasaRovercollectionView.delegate = self
        
        networkFetchService.fetchDataNasaRover { model in
            DispatchQueue.main.async {
                self.arrayPhoto = model
                self.NasaRovercollectionView.reloadData()
            }
        }
    }
}

extension NasaRoverViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayPhoto?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NasaRoverCollectionViewCell
        
        let image = arrayPhoto.photos[indexPath.row].imgSrc
        
        networkFetchService.fecthImage(urlString: image) { image in
            DispatchQueue.main.async {
                cell.nasaImage.image = image
            }
        }
        
//        NetworkingManager.shared.fecthImage(urlString: image) { image in
//            DispatchQueue.main.async {
//                cell.nasaImage.image = image
//            }
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCv = collectionView.frame
        
        let widthCell = frameCv.width / CGFloat(countCell)
        let heighCell = widthCell
        
        let spacing = CGFloat((countCell + 1)) * offset / CGFloat(countCell)
        
        return CGSize(width: widthCell - spacing , height: heighCell - (offset * 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "NasaRover", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NasaRover" {
            let vc = segue.destination as! NasaRoverSecondViewController
            let indexPath = sender as! IndexPath
            
            let photo = arrayPhoto.photos[indexPath.row]
            vc.photoGallery = photo
        }
    }
}
