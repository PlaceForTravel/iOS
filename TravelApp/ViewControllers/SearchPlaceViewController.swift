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
                /// 제스처 인식기가 추가된 뷰. 여기서는 self.view
                guard let targetView: UIView = gesture.view else { return }
                let location: CGPoint = gesture.location(in: targetView)
                /// 타겟뷰의 터치 위치에서 제일 앞의 뷰
                guard let hitView: UIView = targetView.hitTest(location, with: nil) else { return }
                if hitView == targetView {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }

}
