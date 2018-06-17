//
//  WebServiceManager.swift
//  DocTalkTask
//
//  Created by Abhisek on 08/01/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit
import RxSwift

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
        
        return URLSession.shared.rx.json(request: request).map { json -> ([String: AnyObject]?, String?) in
            guard let jsonResponse = json as? [String: AnyObject] else {
                return (nil, "Something went wrong!")
            }
            
            return (jsonResponse, nil)
        }
    }
    
}
