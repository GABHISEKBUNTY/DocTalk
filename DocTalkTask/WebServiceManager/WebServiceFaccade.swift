//
//  WebServiceFaccade.swift
//  DocTalkTask
//
//  Created by Abhisek on 6/17/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation
import RxSwift

class WebServiceRequest {
    
    class func searchUser(searchText: String, manager: WebServiceManagerProtocol) -> Observable<([User]?, String?)> {
        let request = SearchGithubUserWebServiceRequest(manager: manager, searchText: searchText)
        return request.start()
    }
    
}
