//
//  UploadViewController.swift
//  TravelApp
//
//  Created by JDeoks on 2/26/24.
//

import UIKit
import PhotosUI
import RxSwift
import RxCocoa
import RxGesture

class UploadViewController: UIViewController {
    
    /// 선택된 결과를 저장하는 PHPickerResult 배열
    var selectedResults: [PHPickerResult] = []
    var selectedUIImages: [IndexedImage] = []
    
    let disposBag = DisposeBag()

    @IBOutlet var closeButton: UIButton!
    @IBOutlet var uploadImageCollectionView: UICollectionView!
    @IBOutlet var selectPlaceButtonStackView: UIStackView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentPicker()
        initUI()
        action()
    }

    // MARK: - initUI
    private func initUI() {
        // uploadImageCollectionView
        uploadImageCollectionView.dataSource = self
        uploadImageCollectionView.delegate = self
        let uploadImageCollectionViewCell = UINib(nibName: "UploadImageCollectionViewCell", bundle: nil)
        uploadImageCollectionView.register(uploadImageCollectionViewCell, forCellWithReuseIdentifier: "UploadImageCollectionViewCell")
        let uploadImageCollectionViewFlowLayout = UICollectionViewFlowLayout()
        uploadImageCollectionViewFlowLayout.scrollDirection = .horizontal
        uploadImageCollectionView.collectionViewLayout = uploadImageCollectionViewFlowLayout
        uploadImageCollectionView.isPagingEnabled = true
        
        // selectPlaceButtonStackView
        selectPlaceButtonStackView.layer.borderWidth = 1
        selectPlaceButtonStackView.layer.borderColor = UIColor.black.cgColor
        selectPlaceButtonStackView.layer.cornerRadius = 12
    }
    
    // MARK: - action
    private func action() {
        // 닫기 버튼
        closeButton.rx.tap
            .subscribe { _ in
                self.dismiss(animated: true)
            }
            .disposed(by: disposBag)
        
        // 장소 선택 버튼
        selectPlaceButtonStackView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                SceneManager.shared.presentSearchPlaceVC(vc: self)
            })
            .disposed(by: disposBag)
        
    }

}

// MARK: - UICollectionView
extension UploadViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = uploadImageCollectionView.dequeueReusableCell(withReuseIdentifier: "UploadImageCollectionViewCell", for: indexPath) as! UploadImageCollectionViewCell
        if let indexedImage = selectedUIImages.first(where: { $0.index == indexPath.row }) {
            cell.setData(image: indexedImage.image)
        } else {
            cell.setData(image: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 섹션 간의 수직 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 섹션 내 아이템 간의 수평 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - PHPickerViewController
extension UploadViewController: PHPickerViewControllerDelegate {
    
    func presentPicker() {
        // PHPicker의 설정을 구성
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        
        // 사용자 선택에 따라 필터 유형 설정
        configuration.filter = .images
        // 가능하다면, 변환을 피하기 위해 현재의 자산 표현 모드 설정
        configuration.preferredAssetRepresentationMode = .current
        // 사용자의 선택 순서를 존중하기 위해 선택 동작 설정
        configuration.selection = .ordered
        // 다중 선택을 가능하게 하기 위해 선택 제한 설정
        configuration.selectionLimit = 0

        // configuration
        if #available(iOS 17.0, *) {
//            configuration.mode = .compact
            configuration.disabledCapabilities = .ArrayLiteralElement(arrayLiteral: [.collectionNavigation, .search, .stagingArea,])
        } else {
            // Fallback on earlier versions
        }
        
        // 설정된 구성으로 PHPickerViewController 생성 및 표시
        let picker = PHPickerViewController(configuration: configuration)
        self.addChild(picker)
        picker.view.frame = view.frame
        self.view.addSubview(picker.view)
        picker.didMove(toParent: self)
        picker.delegate = self
    }
    
    // 선택 완료 델리게이트
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // results 이미 선택한 배열에 추가
        self.selectedResults += results
        if selectedResults.isEmpty {
            dismiss(animated: true)
        }
        
        let itemProviders: [NSItemProvider] = selectedResults.map { $0.itemProvider }

        for (index, itemProvider) in itemProviders.enumerated() {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self?.selectedUIImages.append(IndexedImage(index: index, image: image))
                        self?.uploadImageCollectionView.reloadData()
                    }
                }
            }
        }
        
        // PHPickerViewController 닫기
        // PHPickerViewController 뷰를 뷰 계층에서 제거
        picker.view.removeFromSuperview()
        // PHPickerViewController가 부모 뷰 컨트롤러에서 제거될 것임을 알림
        picker.willMove(toParent: nil)
        // PHPickerViewController를 자식 뷰 컨트롤러 목록에서 제거
        picker.removeFromParent()
        // 부모 뷰 컨트롤러 변경 완료 알림
        picker.didMove(toParent: nil)
    }
    
}
