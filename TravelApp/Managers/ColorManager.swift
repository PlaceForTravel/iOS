//
//  ColorManager.swift
//  TravelApp
//
//  Created by JDeoks on 2/19/24.
//

import Foundation
import UIKit

class ColorManager {
    
    static let shared = ColorManager()
    
    private init() { }
    
    let primary: UIColor! = UIColor(named: "Primary-Main")
    let secondary: UIColor! = UIColor(named: "Secondary-Sub")
    let primaryBorder: UIColor! = UIColor(named: "PrimaryBorder")
    let secondaryBorder: UIColor! = UIColor(named: "SecondaryBorder")
    let selectedIcon: UIColor! = UIColor(named: "SelectedIcon")
    let unselectedIcon: UIColor! = UIColor(named: "UnselectedIcon")
    let mainBackground: UIColor! = UIColor(named: "MainBackground")
    let subBackground: UIColor! = UIColor(named: "SubBackground")
    let mainText: UIColor! = UIColor(named: "MainText")
    let subText: UIColor! = UIColor(named: "SubText")
    let error: UIColor! = UIColor(named: "Error")

}
