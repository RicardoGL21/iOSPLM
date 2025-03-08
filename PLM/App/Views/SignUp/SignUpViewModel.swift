//
//  SignUpViewModel.swift
//  PLM
//
//  Created by Ricardo Garcia on 06/03/25.
//

import SwiftUI
import Alamofire

class SignUpViewModel: ObservableObject {
    
    func getProfession(completion: @escaping (Result<[ResponseGetProfessions.ProfessionResult], ErrorService>) -> Void) {
        let url = "https://dev.plmconnection.com/plmservices/RestPLMClientsEngine/RestPLMClientsEngine.svc/getProfessions"

        AF.request(url, method: .get, headers: nil)
            .validate()
            .responseDecodable(of: ResponseGetProfessions.self) { response in
                switch response.result {
                case .success(let captureResponse):
                    print(captureResponse)
                    if let professions = captureResponse.getProfessionsResult, !professions.isEmpty {
                        completion(.success(professions))
                    } else {
                        completion(.failure(ErrorService(message: "Error al obtener los datos")))
                    }
                case .failure(let error):
                    print(error)
                    completion(.failure(ErrorService(message: "Error al obtener los datos")))
                }
            }
    }
    
    func getCountries(completion: @escaping (Result<[ResponseGetCountries.CountriesResult], ErrorService>) -> Void) {
        let url = "https://dev.plmconnection.com/plmservices/RestPLMClientsEngine/RestPLMClientsEngine.svc/getCountries"

        AF.request(url, method: .get, headers: nil)
            .validate()
            .responseDecodable(of: ResponseGetCountries.self) { response in
                switch response.result {
                case .success(let captureResponse):
                    print(captureResponse)
                    if let countries = captureResponse.getCountriesResult, !countries.isEmpty {
                        completion(.success(countries))
                    } else {
                        completion(.failure(ErrorService(message: "Error al obtener los datos")))
                    }
                case .failure(let error):
                    print(error)
                    completion(.failure(ErrorService(message: "Error al obtener los datos")))
                }
            }
    }
    
    func getStates(idCountry:String,completion: @escaping (Result<[ResponseGetStates.StateByCountry], ErrorService>) -> Void) {
        let url = "https://dev.plmconnection.com/plmservices/RestPLMClientsEngine/RestPLMClientsEngine.svc/getStateByCountry?countryId=\(idCountry)"

        AF.request(url, method: .get, headers: nil)
            .validate()
            .responseDecodable(of: ResponseGetStates.self) { response in
                switch response.result {
                case .success(let captureResponse):
                    print(captureResponse)
                    if let states = captureResponse.getStateByCountryResult {
                        completion(.success(states))
                    } else {
                        completion(.failure(ErrorService(message: "Error al obtener los datos")))
                    }
                case .failure(let error):
                    print(error)
                    completion(.failure(ErrorService(message: "Error al obtener los datos")))
                }
            }
    }
    
    func createAccount(request:RequestCreateUser, completion: @escaping(Result<String,ErrorService>) -> Void) {
        let url = "https://dev.plmconnection.com/plmservices/RestPLMClientsEngine/RestPLMClientsEngine.svc/saveMobileLocationAppClient"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .responseDecodable(of: ResponseCreateUser.self) { response in
                switch response.result {
                case .success(let captureResponse):
                    print(captureResponse)
                    if let code = captureResponse.saveMobileLocationAppClientResult {
                        completion(.success(code))
                    } else {
                        completion(.failure(ErrorService(message: "Error al obtener los datos")))
                    }
                case .failure(let error):
                    print(error)
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print("Servidor error: \(responseString)")
                    }
                    completion(.failure(ErrorService(message: "Error al obtener los datos")))
                }
            }
        
    }

    
}

struct ErrorService:Error {
    let message:String
}
