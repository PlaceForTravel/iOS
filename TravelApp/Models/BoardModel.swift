//
//  BoardModel.swift
//  TravelApp
//
//  Created by JDeoks on 3/9/24.
//

import Foundation

struct BoardResponse: Codable {
    
    let content: [BoardModel]
    let totalElements: Int
    let pageable: Pageable
    let sort: Sort
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // content
        content = try container.decode([BoardModel].self, forKey: .content)
        
        // totalElements
        totalElements = try container.decode(Int.self, forKey: .totalElements)
        
        // pageable
        pageable = try container.decode(Pageable.self, forKey: .pageable)
        
        // sort
        sort = try container.decode(Sort.self, forKey: .sort)
    }
    
    struct Pageable: Codable {
        let sort: Sort
        let offset: Int
        let pageNumber: Int
        let pageSize: Int
        let paged: Bool
        let unpaged: Bool
    }
    
    struct Sort: Codable {
        let empty: Bool
        let sorted: Bool
        let unsorted: Bool
    }
    
    static func decode(jsonString: String) -> BoardResponse? {
        print("\(type(of: self)) - \(#function)")
        
        guard let jsonData: Data = jsonString.data(using: .utf8) else {
            print("Error: JSON 문자열을 Data 객체로 변환할 수 없음.")
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let response = try decoder.decode(BoardResponse.self, from: jsonData)
            return response
        } catch {
            print("Decoding error: \(error)")
            return nil
        }
    }
    
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

extension BoardResponse: CustomStringConvertible {
    var description: String {
        let contentDescriptions = content.map { $0.description }.joined(separator: ", ")
        return "Content: [\(contentDescriptions)], Total Elements: \(totalElements), Pageable: \(pageable), Sort: \(sort)"
    }
}

extension BoardModel: CustomStringConvertible {
    var description: String {
        "Board ID: \(boardId), User ID: \(userId), Like Count: \(likeCount), Nickname: \(nickname), Registration Date: \(regDate as Any), Modified Date: \(modifiedDate as Any), Deleted Date: \(deletedDate as Any), City Name: \(cityName), Image URLs: \(imageURLs), Like: \(like)"
    }
}

// Pageable과 Sort 구조체에도 CustomStringConvertible 적용
extension BoardResponse.Pageable: CustomStringConvertible {
    var description: String {
        "Sort: \(sort), Offset: \(offset), Page Number: \(pageNumber), Page Size: \(pageSize), Paged: \(paged), Unpaged: \(unpaged)"
    }
}

extension BoardResponse.Sort: CustomStringConvertible {
    var description: String {
        "Empty: \(empty), Sorted: \(sorted), Unsorted: \(unsorted)"
    }
}
