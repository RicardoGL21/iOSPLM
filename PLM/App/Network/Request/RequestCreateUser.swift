//
//  RequestCreateUser.swift
//  PLM
//
//  Created by Ricardo Garcia on 06/03/25.
//

import Foundation

struct RequestCreateUser: Codable {
    var codePrefix:String
    var country:String
    var email:String
    var firstName:String
    var lastName:String
    var phone:String
    var profession:Int
    var professionLicense:String
    var slastName:String
    var source: Int
    var state:String
    var targetOutput:Int
}
