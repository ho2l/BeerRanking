//
//  beerClass.swift
//  BeerRanking
//
//  Created by Developer on 24/03/2015.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import Foundation

class Beer{
    var id:String?
    var name:String?
    var description:String?
    var rate:Float?
    
    init(){
        
    }
    
    init(id:String, name:String, description:String, rate:Float){
        self.id=id
        self.name=name
        self.description=description
        self.rate=rate
    }
    
    func change(id:String, name:String, description:String, rate:Float){
        self.id=id
        self.name=name
        self.description=description
        self.rate=rate
    }
    
    
}

