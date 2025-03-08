//
//  ResponseGetCountries.swift
//  PLM
//
//  Created by Ricardo Garcia on 06/03/25.
//

import Foundation

struct ResponseGetCountries: Codable {
    let getCountriesResult:[CountriesResult]?
    
    struct CountriesResult: Codable {
        let Active:Bool?
        let CountryCode:String?
        let CountryId:Int?
        let CountryLada:String?
        let CountryName:String?
        let ID:String?
    }
    
}
