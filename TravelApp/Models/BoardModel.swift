//
//  BoardModel.swift
//  TravelApp
//
//  Created by JDeoks on 3/9/24.
//

import Foundation

struct BoardResponse: Codable {
    let content: [BoardModel]
}

struct BoardModel: Codable {
    
    let boardId: Int
    let userId: String
    let likeCount: Int
    let nickname: String
    let regDate: Date?
    let modifiedDate: Date?
    let deletedDate: Date?
    let cityName: String
    let imageURLs: [URL]
    let like: Bool
    
    private enum CodingKeys: String, CodingKey {
        case boardId
        case userId
        case likeCount
        case nickname
        case regDate
        case modifiedDate
        case deletedDate
        case cityName
        case imageURLs = "imgUrl"
        case like
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // boardId
        self.boardId = try container.decode(Int.self, forKey: .boardId)
        
        // userId
        self.userId = try container.decode(String.self, forKey: .userId)
        
        // likeCount
        self.likeCount = try container.decode(Int.self, forKey: .likeCount)
        
        // nickname
        self.nickname = try container.decode(String.self, forKey: .nickname)
        
        // regDate
        let regDateStr = try container.decodeIfPresent(String.self, forKey: .regDate)
        self.regDate = DateManager.shared.dateFromString(regDateStr ?? "")
        
        // modifiedDate
        let modifiedDateStr = try container.decodeIfPresent(String.self, forKey: .modifiedDate)
        self.modifiedDate = DateManager.shared.dateFromString(modifiedDateStr ?? "")
        
        // deletedDate
        let deletedDateStr = try container.decodeIfPresent(String.self, forKey: .deletedDate)
        self.deletedDate = DateManager.shared.dateFromString(deletedDateStr ?? "")
        
        // deletedDate
        self.cityName =  try container.decode(String.self, forKey: .cityName)
        
        // imgURLs
        self.imageURLs = try container.decodeIfPresent([URL].self, forKey: .imageURLs) ?? []
        
        // like
        self.like = try container.decode(Bool.self, forKey: .like)
    }
    
}
