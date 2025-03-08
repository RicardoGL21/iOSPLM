//
//  ResponseGetStates.swift
//  PLM
//
//  Created by Ricardo Garcia on 06/03/25.
//

import Foundation

struct ResponseGetStates:Codable {
    let getStateByCountryResult:[StateByCountry]?
    
    struct StateByCountry:Codable {
        let Active:Bool?
        let CountryId:Int?
        let ShortName:String?
        let StateId:Int?
        let StateName:String?
    }
    
}
