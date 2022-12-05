//
//  NationWeather.swift
//  HowsTheWeatherLike
//
//  Created by 최우태 on 2022/12/04.
//

import Foundation

struct NationWeatherM : Codable {
    var korean_name : String
    var asset_name : String
}

struct NationWeatherD : Codable {
    var city_name : String
    var state : Int
    var celsius : Double
    var rainfall_probability : Int
}
