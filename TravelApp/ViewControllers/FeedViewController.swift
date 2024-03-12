//
//  FeedViewController.swift
//  TravelApp
//
//  Created by JDeoks on 2/19/24.
//

import UIKit
import RxSwift
import RxGesture

class FeedViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    @IBOutlet var searchStackView: UIStackView!
    @IBOutlet var feedTableView: UITableView!
    @IBOutlet var uploadButtonView: UIView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initData()
        action()
        bind()
    }
    
    // MARK: - initUI
    private func initUI() {
        // 내비게이션
        self.navigationController?.navigationBar.isHidden = true
        // searchStackView
        searchStackView.layer.borderWidth = 1
        searchStackView.layer.borderColor = ColorManager.shared.secondaryBorder.cgColor
        searchStackView.layer.cornerRadius = searchStackView.frame.height/2
        
        // feedTableView
        feedTableView.dataSource = self
        feedTableView.delegate = self
        let feedTableViewCell = UINib(nibName: "FeedTableViewCell", bundle: nil)
        feedTableView.register(feedTableViewCell, forCellReuseIdentifier: "FeedTableViewCell")
        
        // writeButtonView
        uploadButtonView.layer.cornerRadius = 8
        uploadButtonView.layer.borderWidth = 2
        uploadButtonView.layer.borderColor = ColorManager.shared.secondary.cgColor
    }
    
    // MARK: - initData
    private func initData() {
        DataManager.shared.fetchBoards()
    }
    
    // MARK: - action
    private func action() {
        // 검색 버튼
        searchStackView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                SceneManager.shared.pushSearchVC(vc: self)
            })
            .disposed(by: disposeBag)
        
        // 글 쓰기 버튼
        uploadButtonView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                SceneManager.shared.presentUploadVC(vc: self)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - bind
    private func bind() {
        DataManager.shared.fetchBoardsDone
            .subscribe { _ in
                print("\(type(of: self)) \(#function)")
                self.feedTableView.reloadData()
            }
            .disposed(by: disposeBag)
    }

}

// MARK: - TableView
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.boards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        cell.selectionStyle = .none
        cell.setData(board: DataManager.shared.boards[indexPath.row])
        return cell
    }
    
}
