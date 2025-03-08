//
//  SearchProductsViewModel.swift
//  PLM
//
//  Created by Ricardo Garcia on 07/03/25.
//

import Foundation
import SwiftUI
import Alamofire

class SearchProductsViewModel: ObservableObject{
    
    func searchDrugs(drug:String, completion: @escaping (Result<[ResponseProducts.DrugsResult], Error>) -> Void) {
        
        let user = UserDefaults.standard.string(forKey: "keyUser")
        
        let baseURL = "https://dev.plmconnection.com/plmservices/RestPLMPharmaSearchEngine/RestPharmaSearchEngine.svc/getDrugs?code=\(user ?? "")&countryId=11&editionId=211&drug=\(drug)"

        print(baseURL)

        AF.request(baseURL, method: .get)
            .validate()
            .responseDecodable(of: ResponseProducts.self) { response in
                switch response.result {
                case .success(let captureResponse):
                    print(captureResponse)
                    if let drugsResult = captureResponse.getDrugsResult {
                        completion(.success(drugsResult))
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
    
    //MARK: IGNORE, THIS SERVICE IS ONLY FOR TESTING
    func searchDrugsMocky(drug:String, completion: @escaping (Result<[ResponseProducts.DrugsResult], Error>) -> Void) {
        
        let user = UserDefaults.standard.string(forKey: "keyUser")
        
        let baseURL = "https://run.mocky.io/v3/7612b18c-df96-4d01-8f08-a09b71c7c781"

        print(baseURL)

        AF.request(baseURL, method: .get)
            .validate()
            .responseDecodable(of: ResponseProducts.self) { response in
                switch response.result {
                case .success(let captureResponse):
                    print(captureResponse)
                    if let drugsResult = captureResponse.getDrugsResult {
                        completion(.success(drugsResult))
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
