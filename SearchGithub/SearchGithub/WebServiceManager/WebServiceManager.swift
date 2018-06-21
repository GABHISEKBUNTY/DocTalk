//
//  WebServiceManager.swift
//  SearchGitHub
//
//  Created by Abhisek on 08/01/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit
import RxSwift

struct WebserviceConstants {
    
    struct ErrorMessage {
        static let ignoreMessage = "ignoreMessage"
    }
    
}

enum APIType {
    case POST
    case GET
}

protocol WebServiceManagerProtocol {
    func requestAPI(url: String,parameter: [String: AnyObject]?, httpMethodType: APIType) -> Observable<([String: AnyObject]?,String?)>
}

class WebServiceManager: WebServiceManagerProtocol {
    
    enum HTTPMethodType: Int {
        case POST = 0
        case GET
    }
    
    func requestAPI(url: String,parameter: [String: AnyObject]?, httpMethodType: APIType) -> Observable<([String: AnyObject]?,String?)>  {
        
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: escapedAddress!)!)
        
        switch httpMethodType {
        case .POST:
            request.httpMethod = "POST"
        case .GET:
            request.httpMethod = "GET"
        }
        if parameter != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter as Any, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return Observable.just((nil, error.localizedDescription))
            }
        }
        
        return URLSession.shared.rx.response(request: request)
            .debug("my request") // this will print out information to console
            .flatMap({ (response) -> Observable<([String: AnyObject]?,String?)> in
                let (httpResponse, data) = response
                guard 200 ..< 300 ~= httpResponse.statusCode else { return Observable.just((nil, WebserviceConstants.ErrorMessage.ignoreMessage)) }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        return Observable.just((json as [String : AnyObject],nil))
                    }
                } catch let error {
                    return Observable.just((nil,error.localizedDescription))
                }
                return Observable.just((nil, "Something went wrong!"))
            })
        
    }
    
}
