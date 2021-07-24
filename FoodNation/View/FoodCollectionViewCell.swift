//
//  FoodCollectionViewCell.swift
//  FoodNation
//
//  Created by Aakash Sinha on 23/07/21.
//

import UIKit


protocol SendToFavouritesDelegate {
    func addToFavorite(details: [String])
}


class FoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImgView: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var delegate: SendToFavouritesDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
}




