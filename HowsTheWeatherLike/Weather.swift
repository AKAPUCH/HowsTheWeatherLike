//
//  Weather.swift
//  HowsTheWeatherLike
//
//  Created by 최우태 on 2022/12/09.
//

import Foundation

struct Weather { //dto
    
    
    private var korean_name : String
    private var asset_name : String
    private var city_name : String
    private var state : Int
    private var celsius : Double
    private var rainfall_probability : Int
    
    
     init(korean_name: String, asset_name: String, city_name: String, state: Int, celsius: Double, rainfall_probability: Int) {
        self.korean_name = korean_name
        self.asset_name = asset_name
        self.city_name = city_name
        self.state = state
        self.celsius = celsius
        self.rainfall_probability = rainfall_probability
    }

    
    func getKorean_Name() -> String {
        return self.korean_name
    }
    
    func getAsset_Name() -> String {
        return self.asset_name
    }
    
    func getCity_Name() -> String {
        return self.city_name
    }
    
    func getState() -> Int {
        return self.state
    }
    
    func getCecius() -> Double{
        return self.celsius
    }
    
    func getRainfall_Probability() -> Int {
        return self.rainfall_probability
    }
    
    mutating func setKorean_Name(_ korean_name: String){
        self.korean_name = korean_name
    }
    
    mutating func setAsset_Name(_ asset_name: String){
        self.asset_name = asset_name
    }
    
    mutating func setCity_Name(_ city_name: String){
        self.city_name = city_name
    }
    
    mutating func setState(_ state: Int){
        self.state = state
    }
    
    mutating func setCelcius(_ celcius: Double){
        self.celsius = celcius
    }
    
    mutating func setRainfall_Probability(_ rainfall_probability : Int){
        self.rainfall_probability = rainfall_probability
    }
    
}
