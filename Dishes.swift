//
//  Dishes.swift
//  GetJson
//
//  Created by sss123 on 3/24/19.
//  Copyright © 2019 sss123. All rights reserved.
//

import Foundation

struct MealDishes:Decodable{
    
    let mealdishes:[Dishes]
}
struct Dishes:Decodable{
    let name:String
    let price: Double
    let component : String
}
