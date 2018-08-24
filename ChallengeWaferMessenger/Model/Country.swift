//
//  Country.swift
//  ChallengeWaferMessenger
//
//  Created by Fernanda de Lima on 21/08/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

class Country: NSObject, Codable{
    var name:String             = ""
    var currencies :[Currency]  = [Currency]()
    var languages  :[Language]  = [Language]()

}

class Currency: NSObject, Codable{
    var name: String? = nil
}

class Language: NSObject, Codable{
    var name: String = ""
}

