//
//  ViewController.swift
//  FoodNation
//
//  Created by Aakash Sinha on 22/07/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    
    var ntwrkManager = NetworkManager()
    
    var foodItemsArray : [String] = []
    
    var foodImgArray: [String] = []
    
    var favFoodArray: [String] = []
    var favImageArray: [String] = []
    var filteredData: [String]!
    
    @IBOutlet weak var searchDishes: UISearchBar!
    @IBOutlet weak var foodCView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ntwrkManager.delegate = self
        
        fetchData()
        
        searchDishes.delegate = self
        
        foodCView.dataSource = self
        foodCView.delegate = self
        
        
    }
    
    @IBAction func goToFav(_ sender: Any) {
        let favView = self.storyboard?.instantiateViewController(identifier: "favViewController") as! FavouritesViewController
        favView.favFoodImageArray = favImageArray
        favView.favFoodNameArray = favFoodArray
        self.navigationController!.pushViewController(favView, animated: true)
    }
    func fetchData() {
        ntwrkManager.fetchFoodItems()
        self.showSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    
    
    
}


extension ViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return foodItemsArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foodCView.dequeueReusableCell(withReuseIdentifier: "foodReusableCell", for: indexPath as IndexPath) as! FoodCollectionViewCell
        
        cell.foodImgView?.sd_setImage( with: URL(string: foodImgArray[indexPath.row])!, placeholderImage: UIImage(named: "food"))
        
        cell.foodLabel?.text = foodItemsArray[indexPath.row]
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(addToFav), for: .touchUpInside)
        return cell
    }
    
    @objc func addToFav(sender: UIButton) {
        let indexPathNew = IndexPath(row: sender.tag, section: 0)
        sender.tintColor = UIColor.orange
        self.favFoodArray.append(foodItemsArray[indexPathNew.row])
        self.favImageArray.append(foodImgArray[indexPathNew.row])
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.foodCView.frame.size.width / 2) - 5 //some width
        let height = (self.foodCView.frame.size.width / 2) - 5  //ratio
        return CGSize(width: width, height: height)
    }
}

extension ViewController: UISearchBarDelegate {
    
    
    
    func searchBarSearchButtonClicked(_ searchDishes: UISearchBar) {
        
        self.showSpinner()
        
        if searchDishes.text?.isEmpty == true {
            ntwrkManager.fetchFoodItems()
        }
        else {
            ntwrkManager.searchFoodItems(foodName: searchDishes.text ?? "")
        }
        
    }
}


extension ViewController: FoodItemsDelegate {
    
    func sendDataToViewController(foodNameArray: [String]?, foodImageArray: [String]?) {
        self.foodItemsArray = []
        self.foodImgArray = []
        DispatchQueue.main.async {
            self.foodItemsArray = foodNameArray!
            self.foodImgArray = foodImageArray!
            
            
            self.removeSpinner()
            self.foodCView.reloadData()
        }
        
    }
}




