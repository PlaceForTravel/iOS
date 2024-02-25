//
//  SearchViewController.swift
//  TravelApp
//
//  Created by JDeoks on 2/19/24.
//

import UIKit
import RxSwift
import RxGesture

class SearchViewController: UIViewController {
    
    let disposBag = DisposeBag()

    @IBOutlet var backButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchHistoryTableView: UITableView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        action()
    }
    
    // MARK: - initUI
    private func initUI() {
        // searchHistoryTableView
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.delegate = self
        let searchHistoryTableViewCell = UINib(nibName: "SearchHistoryTableViewCell", bundle: nil)
        searchHistoryTableView.register(searchHistoryTableViewCell, forCellReuseIdentifier: "SearchHistoryTableViewCell")
    }
    
    // MARK: - action
    private func action() {
        // 뒤로가기
        backButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposBag)
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchHistoryTableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell") as! SearchHistoryTableViewCell
        return cell
    }
    
}
