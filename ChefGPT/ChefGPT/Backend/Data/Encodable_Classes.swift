//
//  Encodable_Classes.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 4/10/23.
//

import Foundation

class Encodable_Extended_Ingredients: NSObject, NSCoding {
    let name: String
    let amount: Double
    let unit: String
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.amount, forKey: "amount")
        coder.encode(self.unit, forKey: "unit")
    }
    
    init(name:String, amount:Double, unit:String) {
        self.name = name
        self.amount = amount
        self.unit = unit
    }
    
    required init?(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.amount = decoder.decodeDouble(forKey: "amount") as Double
        self.unit = decoder.decodeObject(forKey: "unit") as! String
    }
    
    
}

class Encodable_Instructions: NSObject, NSCoding {
    let name: String
    var steps: [Encodable_Steps]
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.steps, forKey: "steps")
    }
    
    init(name:String, steps:[Encodable_Steps]) {
        self.name = name
        self.steps = steps
    }
    
    required init?(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.steps = decoder.decodeObject(forKey: "steps") as! [Encodable_Steps]
    }
    
}

class Encodable_Steps: NSObject, NSCoding {
    let number: Int
    let step: String
    
    func encode(with coder: NSCoder) {
        coder.encode(self.number, forKey: "number")
        coder.encode(self.step, forKey: "step")
    }
    
    init(number:Int, step:String) {
        self.number = number
        self.step = step
    }
    
    required init?(coder decoder: NSCoder) {
        self.number = decoder.decodeInteger(forKey: "number") as Int
        self.step = decoder.decodeObject(forKey: "step") as! String
    }
}
