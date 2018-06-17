//
//  SearchUserListController.swift
//  DocTalkTask
//
//  Created by Abhisek on 6/17/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchUserListController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: SearchUserListViewModel! {
        didSet {
            setUpBinding()
        }
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserTableCell.registerWithTable(tableView)
        viewModel = SearchUserListViewModel(webServiceManager: WebServiceManager())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpBinding() {
        searchTextField.rx.controlEvent(UIControlEvents.editingChanged).subscribe(onNext: { [weak self] _ in
            self?.viewModel.textFieldValueEntered.onNext(self?.searchTextField.text ?? "")
        }).disposed(by: disposeBag)
        
        viewModel.tableDataSource.bind(to: tableView.rx.items){
            (tableView: UITableView, index: Int, viewModel: UserTableCellViewModelRepresentable) in
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableCell.reuseIdentifier, for: IndexPath(row: index, section: 0)) as! UserTableCell
            cell.prepareCell(withViewModel: viewModel)
            return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(UserTableCellViewModelRepresentable.self).subscribe { viewModel in
            
        }.disposed(by: disposeBag)
        
    }

}

