//
//  UserTableCellViewModel.swift
//  DocTalkTask
//
//  Created by Abhisek on 6/17/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation
import RxSwift

protocol UserTableCellViewModelRepresentable {
    var imageURL: Observable<String> { get }
    var titleLabelText: Observable<String> { get }
    var subTitleLabelText: Observable<String> { get }
}

class UserTableCellViewModel: UserTableCellViewModelRepresentable {
    
    var imageURL: Observable<String> = Observable.empty()
    var titleLabelText: Observable<String> = Observable.empty()
    var subTitleLabelText: Observable<String> = Observable.empty()
    
    init() {
    }
    
    init(userData: User) {
        self.imageURL = Observable.just(userData.avatarUrl)
        self.titleLabelText = Observable.just(userData.gitHubId)
        self.subTitleLabelText = Observable.just("SCORE - \(String(format: "%.2f", userData.score))")
    }
    
}
