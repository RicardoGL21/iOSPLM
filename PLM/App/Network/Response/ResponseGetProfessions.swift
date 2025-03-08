//
//  ResponseGetProfessions.swift
//  PLM
//
//  Created by Ricardo Garcia on 06/03/25.
//

import Foundation

struct ResponseGetProfessions: Codable {
    let getProfessionsResult:[ProfessionResult]?
    
    struct ProfessionResult:Codable {
        let Active:Bool?
        let EnglishName:String?
        let ParentId:String?
        let ProfessionId:Int?
        let ProfessionName:String?
        let ReqProfessionalLicense:Bool?
    }
    
}
