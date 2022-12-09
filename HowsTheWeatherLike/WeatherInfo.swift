//
//  WeatherInfo.swift
//  HowsTheWeatherLike
//
//  Created by 최우태 on 2022/12/09.
//

import Foundation

class WeatherInfo { //dao
    
    static let shared : WeatherInfo = WeatherInfo()
    
    private init(){}
    
    var weatherInfo : Weather = Weather(korean_name: "", asset_name: "", city_name: "", state: 0, celsius: 0.0, rainfall_probability: 0)
    
    func getKorean_Name() -> String {
        return weatherInfo.getKorean_Name()
    }
    
    func getAsset_Name() -> String {
        return weatherInfo.getAsset_Name()
    }
    
    func getCity_Name() -> String {
        return weatherInfo.getCity_Name()
    }
    
    func getState() -> Int {
        return weatherInfo.getState()
    }
    
    func getCecius() -> Double{
        return weatherInfo.getCecius()
    }
    
    func getRainfall_Probability() -> Int {
        return weatherInfo.getRainfall_Probability()
    }
    
    func registerKorean_Name(_ korean_name: String){
        return weatherInfo.setKorean_Name(korean_name)
    }
    
    func registerAsset_Name(_ asset_name: String){
        return weatherInfo.setAsset_Name(asset_name)
    }
    
    func registerCity_Name(_ city_name: String){
        return weatherInfo.setCity_Name(city_name)
    }
    
    func registerState(_ state: Int){
        return weatherInfo.setState(state)
    }
    
    func registerCelcius(_ celcius: Double){
        return weatherInfo.setCelcius(celcius)
    }
    
    func registerRainfall_Probability(_ rainfall_probability : Int){
        return weatherInfo.setRainfall_Probability(rainfall_probability)
    }
}
