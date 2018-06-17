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
    
    class func searchUserResult(searchText: String, manager: WebServiceManagerProtocol) -> Observable<([UserResult]?, String?)> {
        let request = SearchGithubUserWebServiceRequest(manager: manager, searchText: searchText)
        return request.start()
    }
    
}
