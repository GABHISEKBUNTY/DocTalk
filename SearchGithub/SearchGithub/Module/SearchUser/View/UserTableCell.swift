//
//  UserTableCell.swift
//  SearchGitHub
//
//  Created by Abhisek on 6/17/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class UserTableCell: ReusableTableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var viewModel: UserTableCellViewModelRepresentable! {
        didSet {
            setUpUI()
        }
    }
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(withViewModel viewModel: UserTableCellViewModelRepresentable) {
        self.viewModel = viewModel
    }
    
    private func setUpUI() {
        viewModel.titleLabelText.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.imageURL.subscribe(onNext: { [weak self] imageURL in
            self?.avatarImage.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named : "profileIcon"), options: nil, progressBlock: nil, completionHandler: nil)
        }).disposed(by: disposeBag)
        viewModel.subTitleLabelText.bind(to: scoreLabel.rx.text).disposed(by: disposeBag)
    }
    
}
