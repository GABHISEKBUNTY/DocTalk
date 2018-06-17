//
//  SearchUserListViewModel.swift
//  DocTalkTask
//
//  Created by Abhisek on 6/17/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchUserListViewModel {
    
    // Output
    var tableDataSource: Observable<[UserTableCellViewModelRepresentable]> = Observable.empty()
    var displayError: Observable<String> = Observable.empty()
    
    // Input
    var textFieldValueEntered: PublishSubject<String> = PublishSubject<String>()
    
    var webServiceManager: WebServiceManagerProtocol!
    
    init(webServiceManager: WebServiceManagerProtocol) {
        self.webServiceManager = webServiceManager
        tableDataSource = getTableDataSource().asObservable()
    }
    
    private func getTableDataSource() -> Driver<[UserTableCellViewModelRepresentable]> {
        return textFieldValueEntered.asObservable().debug().do(onNext: { _ in
            ActivityIndicator.displayActivityIndicator()
        }).observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).flatMapLatest({ [weak self] searchText -> Observable<([User]?,String?)> in
            guard searchText != "" else { return Observable.just((nil, nil)) }
            guard let _self = self else { return Observable.just((nil, "Something went wrong!")) }
            return WebServiceRequest.searchUser(searchText: searchText, manager: _self.webServiceManager)
        }).observeOn(MainScheduler.instance)
            .do(onNext: { _ in
                ActivityIndicator.hideActivityIndicator()
            })
            .map({ response in
                let (userList, errorMessage) = response
                guard let users = userList else {
                    // Show error Message
                    if errorMessage == nil { return [] }
                    Helper.showAlert(message: errorMessage!, title: "Error")
                    return []
                }
                return users.map { UserTableCellViewModel(userData: $0) }
            })
            .asDriver(onErrorJustReturn: [])
    }
    
    
}
