//
//  TransactionsAPI.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation
import Alamofire

//enum NetworkResult<Value> {
//    case success(,Value)
//    case failure(Error)
//}

enum TransactionsAPI {
    case getUserInfos()
    case getTransactionsList()
}

extension TransactionsAPI {
    
    var baseUrl: String {
        return Constants.baseUrl
    }
    
    var path: String {
        switch self {
            
        case .getUserInfos():
            return "userinfo"
        case .getTransactionsList():
            return "transactions"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
            
        default:
            return [:]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case _ where self.method == .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var headers: Alamofire.HTTPHeaders {
        var defaultHeaders = [String: String]()
        
        switch self {
        default:
            defaultHeaders["Content-Type"] = "application/json"
            return defaultHeaders
        }
    }
}

extension TransactionsAPI {
    
    static func request<T: Decodable>(_ endpoint: TransactionsAPI, completion: @escaping (_ result: Result<T>, _ httpResponse: DataResponse<Any>) -> Void) {
        
        Alamofire.request("\(endpoint.baseUrl)\(endpoint.path)", method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: endpoint.headers).responseJSON { (httpResponse: DataResponse<Any>) in
            
            guard let response = httpResponse.response else {
                completion(Result.failure(TransactionsAPIError.unknownResponse), httpResponse)
                return
            }
            
            completion(self.handler(statusCode: response.statusCode, dataResponse: httpResponse), httpResponse)

        }
    }
    
    private static func handler<T: Decodable>(statusCode: Int, dataResponse: DataResponse<Any>) -> Result<T> {
        
        switch statusCode {
        case 200...299:
            return parseJson(dataResponse.result.value)
        case 400:
            return Result.failure(TransactionsAPIError.badRequest)
        case 401:
            return Result.failure(TransactionsAPIError.unauthorized(""))
        case 404:
            return Result.failure(TransactionsAPIError.notFound(""))
        default:
            return Result.failure(TransactionsAPIError.unknownResponse)
        }
    }
    
    private static func parseJson<T: Decodable>(_ responseJson: Any?) -> Result<T> {
        if let json = responseJson {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let object: T = try JSONDecoder().decode(T.self, from: jsonData)
                return Result.success(object)
            } catch {
                return Result.failure(TransactionsAPIError.invalidJson)
            }
        } else {
            return Result.failure(TransactionsAPIError.invalidJson)
        }
    }
    
    private static func parseErrorMessage(_ responseJson: [String: Any]?) -> GenericResponse {
        let genericResponse = GenericResponse()
        
        guard let response = responseJson else {
            return genericResponse
        }
        
        genericResponse.message = response["status_message"] as? String ?? ""
        genericResponse.errorCode = response["status_code"] as? String ?? ""
        
        return genericResponse
    }
}
