//
//  UploadImageCollectionViewCell.swift
//  TravelApp
//
//  Created by JDeoks on 2/26/24.
//

import UIKit

class UploadImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cellIamgeView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    func initUI() {
        cellIamgeView.contentMode = .scaleAspectFill
    }
    
    func setData(image: UIImage?) {
        if let image = image {
            cellIamgeView.image = image
        } else {
            cellIamgeView.image = nil
        }
    }

}
