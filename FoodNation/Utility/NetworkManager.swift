//
//  NetworkManager.swift
//  FoodNation
//
//  Created by Aakash Sinha on 23/07/21.
//

import Foundation

protocol FoodItemsDelegate: AnyObject {
    func sendDataToViewController(foodNameArray: [String]? , foodImageArray: [String]?)
}

class NetworkManager {
    
    var mealName: [String] = []
    var mealImage: [String] = []
    
    weak var delegate: FoodItemsDelegate?
    
    func fetchFoodItems() {
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?f=c")
        guard let requestUrl = url else { fatalError() }
        let request = URLRequest(url: requestUrl)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            do{
                let decodedData = try JSONDecoder().decode(FoodResponse.self, from: data)
                self.mealName = []
                self.mealImage = []
                for key in decodedData.meals {
                    self.mealName.append((key["strMeal"] ?? "No Data Available")!)
                    self.mealImage.append((key["strMealThumb"] ?? "No Data Available")!)
                    
                }
                self.delegate?.sendDataToViewController(foodNameArray: self.mealName, foodImageArray: self.mealImage)
                print(self.mealImage)
            }catch let jsonErr{
                print(jsonErr)
            }
            
        }
        task.resume()
    }
    
    
    
    
    
    func searchFoodItems(foodName: String) {
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(foodName)")
        guard let requestUrl = url else { fatalError() }
        let request = URLRequest(url: requestUrl)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            do{
                let decodedData = try JSONDecoder().decode(FoodResponse.self, from: data)
                self.mealName = []
                self.mealImage = []
                for key in decodedData.meals {
                    self.mealName.append((key["strMeal"] ?? "No Data Available")!)
                    self.mealImage.append((key["strMealThumb"] ?? "No Data Available")!)
                    
                }
                self.delegate?.sendDataToViewController(foodNameArray: self.mealName, foodImageArray: self.mealImage)
                print(self.mealImage)
            }catch let jsonErr{
                print(jsonErr)
            }
            
        }
        task.resume()
    }
    
}
