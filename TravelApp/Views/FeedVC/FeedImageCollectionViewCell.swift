//
//  FeedImageCollectionViewCell.swift
//  TravelApp
//
//  Created by JDeoks on 3/10/24.
//

import UIKit
import Kingfisher

class FeedImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var feedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(board: BoardModel?, indexPath: IndexPath) {
        guard let board = board else {
            return
        }
        if board.imageURLs.indices.contains(indexPath.row) {
            feedImageView.kf.setImage(with: board.imageURLs[indexPath.row])
        }
    }

}
