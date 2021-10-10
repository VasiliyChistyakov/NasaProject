//
//  ViewController.swift
//  NasaProject
//
//  Created by Чистяков Василий Александрович on 07.10.2021.
//

import UIKit

enum Actions: String, CaseIterable {
    
    case NasaImage = "NasaImage"
    case NasaRover = "NasaRover"
}

class MainViewController: UIViewController {
    
    let actions = Actions.allCases
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.label.text = actions[indexPath.row].rawValue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.row]
        
        switch action {
        case .NasaImage:
            performSegue(withIdentifier: "NasaImage", sender: self)
        case .NasaRover:
            performSegue(withIdentifier: "NasaRover", sender: self)
        }
    }
}
