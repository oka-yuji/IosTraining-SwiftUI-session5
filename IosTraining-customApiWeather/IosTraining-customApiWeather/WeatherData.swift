//
//  WeatherData.swift
//  IosTraining-customApiWeather
//
//  Created by 岡優志 on 2021/04/23.
//

import Foundation

struct WeatherData: Codable {
    var max_temp: Int
    var date: Date
    var min_temp: Int
    var weather: String
    
    }
