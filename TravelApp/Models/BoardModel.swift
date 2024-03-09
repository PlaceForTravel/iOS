//
//  BoardModel.swift
//  TravelApp
//
//  Created by JDeoks on 3/9/24.
//

import Foundation

struct BoardResponse: Decodable {
    let content: [BoardModel]
}

struct BoardModel: Decodable {
    
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
    
    enum Key: String {
        case boardId
        case userId
        case likeCount
        case nickname
        case regDate
        case modifiedDate
        case deletedDate
        case cityName
        case imgUrl
        case like
    }
    
    init(data: [String: Any]) {
        self.boardId = data[Key.boardId.rawValue] as? Int ?? 0
        self.userId = data[Key.userId.rawValue] as? String ?? ""
        self.likeCount = data[Key.likeCount.rawValue] as? Int ?? 0
        self.nickname = data[Key.nickname.rawValue] as? String ?? ""
        // regDate
        let regDateStr: String = data[Key.regDate.rawValue] as? String ?? ""
        self.regDate = DateManager.shared.dateFromString(regDateStr)
        // modifiedDate
        let modifiedDateStr: String = data[Key.modifiedDate.rawValue] as? String ?? ""
        self.modifiedDate = DateManager.shared.dateFromString(modifiedDateStr)
        // deletedDate
        let deletedDateStr: String = data[Key.deletedDate.rawValue] as? String ?? ""
        self.deletedDate = DateManager.shared.dateFromString(deletedDateStr)
        
        self.cityName = data[Key.cityName.rawValue] as? String ?? ""
        self.imgUrl = data[Key.imgUrl.rawValue] as? [String] ?? []
        self.like = data[Key.like.rawValue] as? Bool ?? false
    }
    
    static func decode(jsonString: String) -> [BoardModel]? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let response: BoardResponse = try? decoder.decode(BoardResponse.self, from: jsonData) else {
            return nil
        }
        let boards: [BoardModel] = response.content
        return boards
    }
    
}
