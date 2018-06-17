//
//  User.swift
//  DocTalkTask
//
//  Created by Kuliza-241 on 6/17/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

/// Model to store the result from github Search API.
class UserResult {
    
    var gitHubId: String
    var avatarUrl: String
    var gravatarId: String
    var url: String
    var htmlURL: String
    var followersURL: String
    var subscriptionsURL: String
    var organisationsURL: String
    var reposURL: String
    var receivedEventsURL: String
    var type: String
    var score: Double
    
    init(attributes: [String: Any]) {
        gitHubId = attributes["login"] as? String ?? ""
        avatarUrl = attributes["avatar_url"] as? String ?? ""
        gravatarId = attributes["gravatar_id"] as? String ?? ""
        url = attributes["url"] as? String ?? ""
        htmlURL = attributes["html_url"] as? String ?? ""
        followersURL = attributes["followers_url"] as? String ?? ""
        subscriptionsURL = attributes["subscriptions_url"] as? String ?? ""
        organisationsURL = attributes["organizations_url"] as? String ?? ""
        reposURL = attributes["repos_url"] as? String ?? ""
        receivedEventsURL = attributes["received_events_url"] as? String ?? ""
        type = attributes["type"] as? String ?? ""
        score = attributes["score"] as? Double ?? 0.0
    }
    
}

/// Model to store additional user details apart from those available in Search API.
class User: UserResult {
    
    var name: String
    var company: String
    var blog: String
    var gistsURL: String
    //var followers: Int
    
    override init(attributes: [String: Any]) {
        name = attributes["name"] as? String ?? ""
        company = attributes["company"] as? String ?? ""
        blog = attributes["blog"] as? String ?? ""
        gistsURL = attributes["gists_url"] as? String ?? ""
        super.init(attributes: attributes)
    }
    
    
}
