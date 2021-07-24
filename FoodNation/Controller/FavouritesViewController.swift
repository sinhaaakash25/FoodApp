//
//  FavouritesViewController.swift
//  FoodNation
//
//  Created by Aakash Sinha on 24/07/21.
//

import UIKit
import SDWebImage

class FavouritesViewController: UIViewController {
    
    
    var favFoodNameArray: [String] = []
    var favFoodImageArray: [String] = []
    
    @IBOutlet weak var favCView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favCView.dataSource = self
        favCView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
    
}

extension FavouritesViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favFoodNameArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favCView.dequeueReusableCell(withReuseIdentifier: "favReusableCell", for: indexPath as IndexPath) as! FavCollectionViewCell
        
        cell.foodImgView?.sd_setImage( with: URL(string: favFoodImageArray[indexPath.row])!, placeholderImage: UIImage(named: "food"))
        
        cell.foodLabel?.text = favFoodNameArray[indexPath.row]
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.favCView.frame.size.width / 2) - 10 //some width
        let height = (self.favCView.frame.size.width / 2) - 10  //ratio
        return CGSize(width: width, height: height)
    }
}


