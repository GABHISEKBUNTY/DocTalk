//
//  SearchGithub.swift
//  DocTalkTask
//
//  Created by Abhisek on 6/17/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation
import RxSwift

class DCWebServiceRequest {
    
    var manager: WebServiceManagerProtocol
    var url: String
    var parameter: [String: AnyObject]?
    
    init(manager: WebServiceManagerProtocol, url: String, parameter: [String: AnyObject]? = nil) {
        self.manager = manager
        self.url = url
        self.parameter = parameter
    }
    
}

class SearchGithubUserWebServiceRequest: DCWebServiceRequest {
    
    init(manager: WebServiceManagerProtocol, searchText: String) {
        let url = "https://api.github.com/search/users?q=\(searchText)&sort=followers"
        super.init(manager: manager, url: url)
    }
    
    func start() -> Observable<([UserResult]?, String?)> {
        return manager.requestAPI(url: url, parameter: nil, httpMethodType: .GET).map { (returnData) in
            let (responseData, errorMessage) = returnData
            guard let response = responseData, let results = response["items"] as? [[String: AnyObject]] else {
                return (nil, errorMessage!)
            }
            return (results.map { UserResult(attributes: $0) }, nil)
        }
    }
    
}
