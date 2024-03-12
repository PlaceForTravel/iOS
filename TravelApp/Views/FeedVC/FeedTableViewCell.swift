//
//  FeedTableViewCell.swift
//  TravelApp
//
//  Created by JDeoks on 2/19/24.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    // 고민... board을 여기에 저장해도 되는가...?
    private var board: BoardModel? = nil
    
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
    
    override func prepareForReuse() {
        self.board = nil
    }
    
    func setData(board: BoardModel) {
        print("\(type(of: self)) - \(#function)")
        
        // board
        self.board = board
        
        // placeLabel
        placeLabel.text = board.cityName
        
        // writerNameLabel
        writerNameLabel.text = board.nickname
    }
    
    // MARK: - initUI
    private func initUI() {
        // rootStackView
        rootStackView.layer.cornerRadius = 16
        
        // imageCollectionView
        imageCollectionView.layer.cornerRadius = 12
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        let feedImageCollectionViewCell = UINib(nibName: "FeedImageCollectionViewCell", bundle: nil)
        imageCollectionView.register(feedImageCollectionViewCell, forCellWithReuseIdentifier: "FeedImageCollectionViewCell")
        let imageCollectionViewFlowLayout = UICollectionViewFlowLayout()
        imageCollectionViewFlowLayout.scrollDirection = .horizontal
        imageCollectionView.collectionViewLayout = imageCollectionViewFlowLayout
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.bounces = false
        imageCollectionView.showsHorizontalScrollIndicator = false
    }
    
}

extension FeedTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.board?.imageURLs.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedImageCollectionViewCell", for: indexPath) as! FeedImageCollectionViewCell
        cell.setData(board: board, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
