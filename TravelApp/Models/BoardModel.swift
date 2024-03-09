//
//  BoardModel.swift
//  TravelApp
//
//  Created by JDeoks on 3/9/24.
//

import Foundation

struct BoardModel {
    
    let boardId: Int
    let userId: String
    let likeCount: Int
    let nickname: String
    let regDate: Date?
    let modifiedDate: Date?
    let deletedDate: Date?
    let cityName: String
    let imgUrl: [String]
    let like: Bool
    
    init(jsonData: [String: Any]) {
        self.boardId = jsonData["boardId"] as? Int ?? 0
        self.userId = jsonData["userId"] as? String ?? ""
        self.likeCount = jsonData["likeCount"] as? Int ?? 0
        self.nickname = jsonData["nickname"] as? String ?? ""
        
        let regDateStr: String = jsonData["regDate"] as? String ?? ""
        self.regDate = DateManager.shared.dateFromString(regDateStr)
        
        let modifiedDateStr: String = jsonData["modifiedDate"] as? String ?? ""
        self.modifiedDate = DateManager.shared.dateFromString(modifiedDateStr)
               
        let deletedDateStr: String = jsonData["deletedDate"] as? String ?? ""
        self.deletedDate = DateManager.shared.dateFromString(deletedDateStr)
        
        self.cityName = jsonData["cityName"] as? String ?? ""
        self.imgUrl = jsonData["imgUrl"] as? [String] ?? []
        self.like = jsonData["like"] as? Bool ?? false
    }
    
    
}
