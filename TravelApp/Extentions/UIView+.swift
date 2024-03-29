//
//  UIView+.swift
//  TravelApp
//
//  Created by JDeoks on 3/9/24.
//

import Foundation
import UIKit

extension UIView {
    
    /// 현재 뷰가 탭 제스처에 직접 탭되었는지 확인
    ///
    /// `hitTest(_:with:)`를 사용하여 탭 위치에 있는 가장 앞의 뷰를 찾고, 현재 뷰(`self`)와 동일한지 비교.
    ///
    /// - Returns: 현재 뷰가 직접 탭된 경우 true, 그렇지 않으면 (서브뷰가 탭된 경우) false.
    ///
    /// ## 예시
    ///
    /// ``` swift
    /// self.view.rx.tapGesture()
    ///     .when(.recognized)
    ///     .subscribe(onNext: { gesture in
    ///         // 내부 요소가 탭되었을 때는 모달이 닫히지 않음
    ///         if self.view.isTappedDirectly(gesture: gesture) {
    ///             self.dismiss(animated: true, completion: nil)
    ///         }
    ///     })
    ///     .disposed(by: disposeBag)
    /// ```
    func isTappedDirectly(gesture: UITapGestureRecognizer) -> Bool {
        let location = gesture.location(in: self)
        let hitView = self.hitTest(location, with: nil)
        return hitView == self
    }
    
}
