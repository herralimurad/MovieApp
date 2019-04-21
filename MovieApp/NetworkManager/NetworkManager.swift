//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Ali Murad on 20/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import Foundation
import AFNetworking
import SVProgressHUD


enum RequestMethod {
    case GET
    case POST
}

// Request Result have you type of results, success, failure
enum RequestResult {
    case success (data: Any?)
    case failure (errorMsg: String)
}

// Callback for network request
typealias RequestPerformed = (_ result: RequestResult) -> ()

// protocol for dependency injection for networkmanager
protocol NetworkManageable {
    func performRequest(url: String, params: Dictionary<AnyHashable, Any>, method: RequestMethod, requestPerformed: @escaping RequestPerformed)
}

// There i'm using AFNetworking for http request, any library or framework can we use but it's perform request should take url, param and methods, and return RequestResult
class AFNetworkManager: NetworkManageable {
    func performRequest(url: String, params: Dictionary<AnyHashable, Any>, method: RequestMethod, requestPerformed: @escaping RequestPerformed) {
        
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange {
            status in
            switch status {
            case .reachableViaWiFi, .reachableViaWWAN:
                SVProgressHUD.show()
                let manager = AFHTTPSessionManager()
                switch method {
                case .GET:
                    manager.get(url, parameters: params, progress: nil, success: {(dataTask, responseObject) in
                        SVProgressHUD.dismiss()
                        requestPerformed(RequestResult.success(data: responseObject))
                    }, failure: { (_, error) in
                        SVProgressHUD.dismiss()
                        requestPerformed(RequestResult.failure(errorMsg: error.localizedDescription))
                    })
                case .POST:
                    manager.post(url, parameters: params, progress: nil, success: {(dataTask, responseObject) in
                        SVProgressHUD.dismiss()
                        requestPerformed(RequestResult.success(data: responseObject))
                    }, failure: { (_, error) in
                        SVProgressHUD.dismiss()
                        requestPerformed(RequestResult.failure(errorMsg: error.localizedDescription))
                    })
                }
                
            case .unknown, .notReachable:
                SVProgressHUD.dismiss()
                requestPerformed(RequestResult.failure(errorMsg: Messages.NetworkUnavailable))
                
            @unknown default:
                SVProgressHUD.dismiss()
                requestPerformed(RequestResult.failure(errorMsg: Messages.NetworkUnavailable))
            }
        }
        AFNetworkReachabilityManager.shared().startMonitoring()
        
    }
    
    
}
