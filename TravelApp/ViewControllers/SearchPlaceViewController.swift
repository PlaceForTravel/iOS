//
//  SearchPlaceViewController.swift
//  TravelApp
//
//  Created by JDeoks on 3/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class SearchPlaceViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    @IBOutlet var modalContainerView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var seachResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        action()
    }
    
    private func initUI() {
        // containerView
        modalContainerView.layer.cornerRadius = 16
    }
    
    private func action() {
        
        seachResultTableView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                print("seachResultTableView")
            })
            .disposed(by: disposeBag)
        
        // 창 닫기
        self.view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { gesture in
                if self.view.isTappedDirectly(gesture: gesture) {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }

}
