//
//  FeedTableViewCell.swift
//  TravelApp
//
//  Created by JDeoks on 2/19/24.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet var rootStackView: UIStackView!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var imageCollectionView: UICollectionView!
    @IBOutlet var writerNameLabel: UILabel!
    @IBOutlet var relativeTimeLabel: UILabel!
    @IBOutlet var bookmarkButton: UIButton!
    @IBOutlet var bookmarkCountLabel: UILabel!
    
    // MARK: - LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()

        initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - initUI
    private func initUI() {
        // rootStackView
        rootStackView.layer.cornerRadius = 16
        
        // imageCollectionView
        imageCollectionView.layer.cornerRadius = 12
    }
    
}
