//
//  SceneManager.swift
//  TravelApp
//
//  Created by JDeoks on 2/19/24.
//

import UIKit
 
class SceneManager {
    
    static let shared = SceneManager()
    
    private init() { }
    
    enum Scene: String {
        case feedVC = "FeedViewController"
        case searchVC = "SearchViewController"
        case uploadVC = "UploadViewController"
        case searchPlaceVC = "SearchPlaceViewController"
    }
    
    private func getVC(scene: Scene) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: scene.rawValue)
    }
    
    func pushSearchVC(vc: UIViewController) {
        print("\(type(of: self)) - \(#function)")
        
        let searchVC = getVC(scene: .searchVC) as! SearchViewController
        searchVC.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func presentUploadVC(vc: UIViewController) {
        print("\(type(of: self)) - \(#function)")
        
        let uploadVC = getVC(scene: .uploadVC) as! UploadViewController
        uploadVC.modalPresentationStyle = .overFullScreen
//        uploadVC.hidesBottomBarWhenPushed = true
        vc.present(uploadVC, animated: true)
    }
    
    func presentSearchPlaceVC(vc: UIViewController) {
        print("\(type(of: self)) - \(#function)")
        
        let searchPlaceVC = getVC(scene: .searchPlaceVC) as! SearchPlaceViewController
        searchPlaceVC.modalPresentationStyle = .overFullScreen
        searchPlaceVC.modalTransitionStyle = .crossDissolve
        vc.present(searchPlaceVC, animated: true)
    }
}
