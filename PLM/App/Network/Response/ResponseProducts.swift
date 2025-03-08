//
//  ResponseProducts.swift
//  PLM
//
//  Created by Ricardo Garcia on 08/03/25.
//

import Foundation

struct ResponseProducts: Codable {
    let getDrugsResult:[DrugsResult]?
    
    struct DrugsResult:Codable, Identifiable {
        let id = UUID()
        let BaseUrl:String?
        let Brand:String?
        let CategoryName:String?
        let CategotyId:Int?
        let CountryCodes:String?
        let DivisionId:Int?
        let DivisionName:String?
        let DivisionShortName:String?
        let EnglishPharmaForm:String?
        let PharmaForm:String?
        let PharmaFormId:Int?
        let ProductId:Int?
        let ProductShot:String?
        let ProductTypeId:Int?
        let ProductTypeName:String?
    }
    
}
