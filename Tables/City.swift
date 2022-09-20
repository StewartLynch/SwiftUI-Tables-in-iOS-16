//
//  City.swift
//  Tables
//
//  Created by Stewart Lynch on 2022-09-17.
//

import Foundation

struct City: Identifiable, Hashable {
    var name: String
    var country: String
    var population: Int
    var isCapital: Bool = false
    var isCapitalInt: Int {
        isCapital ? 0 : 1
    }
    var id: String {
        name
    }
    
    static var sample: [City] {
        [
            City(name: "Vancouver", country: "Canada",  population:  2632000),
            City(name: "Victoria", country: "Canada",  population: 394000, isCapital: true),
            City(name: "Toronto", country: "Canada",  population: 6313000),
            City(name: "Ottawa", country: "Canada",  population: 1433000),
            City(name: "Seattle", country: "United States",  population: 4102100),
            City(name: "Denver", country: "United States",  population: 2897000),
            City(name: "San Francisco", country: "United States",  population: 3318000),
            City(name: "Washington", country: "United States",  population: 5434000, isCapital: true),
            City(name: "London", country: "United Kingdom",  population: 95410000, isCapital: true),
            City(name: "Glasgow", country: "United Kingdom",  population: 1689000),
            City(name: "Cardiff", country: "United Kingdom",  population: 485000),
            City(name: "Leeds", country: "United Kingdom",  population: 780000),
            City(name: "Edinburgh", country: "United Kingdom",  population: 548000),
            City(name: "Belfast", country: "United Kingdom",  population: 630000),
            City(name: "Lyon", country: "France",  population: 1748000),
            City(name: "Paris", country: "France",  population: 2140000, isCapital: true),
            City(name: "Marseille", country: "France",  population: 1620000),
            City(name: "Toulon", country: "France",  population: 584000),
            City(name: "Nice", country: "France",  population: 945000),
            City(name: "Tijuana", country: "Mexico",  population: 2221000),
            City(name: "Mexico City", country: "Mexico",  population: 22085000, isCapital: true),
            City(name: "Cancun", country: "Mexico",  population: 998000),
            City(name: "Monterrey", country: "Mexico",  population: 1135000),
            City(name: "Iztapalapa", country: "Mexico",  population: 1815000),
            City(name: "Puebla", country: "Mexico",  population: 1434000),
            City(name: "Chihuahua", country: "Mexico",  population: 809232)
        ]
    }
    
    static var countries: [String] {
        return Array(Set(sample.map{$0.country})).sorted(by: <)
    }
}
