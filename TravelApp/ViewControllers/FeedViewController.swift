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
    
    let disposBag = DisposeBag()

    @IBOutlet var searchStackView: UIStackView!
    @IBOutlet var feedTableView: UITableView!
    @IBOutlet var uploadButtonView: UIView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        action()
    }
    
    // MARK: - initUI
    private func initUI() {
        // 내비게이션
        self.navigationController?.navigationBar.isHidden = true
        
        // searchStackView
        searchStackView.layer.borderWidth = 2
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
    
    // MARK: - action
    private func action() {
        // 검색 버튼
        searchStackView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                SceneManager.shared.pushSearchVC(vc: self)
            })
            .disposed(by: disposBag)
        
        // 글 쓰기 버튼
        uploadButtonView.rx.tapGesture()
            .subscribe(onNext: { _ in
                // TODO: 글쓰기
                return
            })
            .disposed(by: disposBag)
    }

}

// MARK: - TableView
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
}
