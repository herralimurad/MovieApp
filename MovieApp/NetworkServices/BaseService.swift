//
//  MovieListService.swift
//  MovieApp
//
//  Created by Ali Murad on 20/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import Foundation

typealias ServiceResult = (_ modelObject: Any?, _ error: String?) -> ()

// protocol for dependency injection for Service,
// it must take a NetworkManageable and DataParser and "request" should be implemented as
//it would take request data, request it on API, get response and return response object
protocol BaseServiceable {
    var networkManager: NetworkManageable { get }
    var dataParser: DataParser { get }
    
    func request<T>(requestData: RequestData, responseModel: T.Type, completionCallback: @escaping ServiceResult) where T: Decodable

}

// I use, AFNetworkManager and JSONParser according to my requirements
class BaseService: BaseServiceable {
   
    let networkManager: NetworkManageable
    let dataParser: DataParser
    
    init(networkManager: NetworkManageable = AFNetworkManager(), dataParser: DataParser = JSONParser()) {
        self.networkManager = networkManager
        self.dataParser = dataParser
    }
    
    
    func request<T>(requestData: RequestData, responseModel: T.Type, completionCallback: @escaping ServiceResult) where T: Decodable {
        networkManager.performRequest(url: requestData.requestURL, params: requestData.requestParams, method: requestData.requestMethod) { [weak self] requestResult in
            guard let `self` = self else { return }
            switch requestResult {
            case .success(let data):
                do {
                    let response = try self.dataParser.parse(type: responseModel, from: data as Any)
                    completionCallback(response, nil)
                    
                } catch let error {
                    completionCallback(nil, error.localizedDescription)
                }
            case .failure(let error):
                completionCallback(nil, error)
                
            }
        }
    }
}
















