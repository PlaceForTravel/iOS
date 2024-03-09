//
//  DataManager.swift
//  TravelApp
//
//  Created by JDeoks on 3/9/24.
//

import Foundation
import RxSwift

class DataManager {
    
    static let shared = DataManager()
    
    private init() { }
    
    
    
    func fetchBoardPosts() {
        let jsonString = """
        {
            "content": [
                {
                    "boardId": 7,
                    "userId": "3293008028",
                    "likeCount": 2,
                    "nickname": "테스트1",
                    "regDate": "2024-02-19T22:38:41.378313",
                    "modifiedDate": null,
                    "deletedDate": null,
                    "cityName": "서울특별시 종로구",
                    "imgUrl": [
                        "https://traveling7-bucket555.s3.ap-northeast-2.amazonaws.com/7_9_2024-02-19",
                        "https://traveling7-bucket555.s3.ap-northeast-2.amazonaws.com/7_10_2024-02-19"
                    ],
                    "like": false
                },
                {
                    "boardId": 6,
                    "userId": "3293008028",
                    "likeCount": 0,
                    "nickname": "테스트1",
                    "regDate": "2024-02-06T23:21:04.496251",
                    "modifiedDate": null,
                    "deletedDate": null,
                    "cityName": "전라남도 여수시",
                    "imgUrl": [
                        "https://traveling7-bucket555.s3.ap-northeast-2.amazonaws.com/6_7_2024-02-06",
                        "https://traveling7-bucket555.s3.ap-northeast-2.amazonaws.com/6_8_2024-02-06"
                    ],
                    "like": false
                },
                {
                    "boardId": 5,
                    "userId": "spS3QNEOtVAd9Bd0oZE0pBEoXyw0YZc_pDsVWZFS4Z0",
                    "likeCount": 1,
                    "nickname": "관리자",
                    "regDate": "2024-02-06T15:24:22.436293",
                    "modifiedDate": null,
                    "deletedDate": null,
                    "cityName": "전라남도 여수시",
                    "imgUrl": [
                        "https://traveling7-bucket555.s3.ap-northeast-2.amazonaws.com/5_5_2024-02-06",
                        "https://traveling7-bucket555.s3.ap-northeast-2.amazonaws.com/5_6_2024-02-06"
                    ],
                    "like": false
                },
                {
                    "boardId": 4,
                    "userId": "spS3QNEOtVAd9Bd0oZE0pBEoXyw0YZc_pDsVWZFS4Z0",
                    "likeCount": 0,
                    "nickname": "관리자",
                    "regDate": "2024-01-23T16:10:25.284176",
                    "modifiedDate": null,
                    "deletedDate": null,
                    "cityName": "전라남도 여수시",
                    "imgUrl": [
                        "https://traveling7-bucket555.s3.ap-northeast-2.amazonaws.com/4_4_2024-01-23"
                    ],
                    "like": false
                },
                {
                    "boardId": 3,
                    "userId": "spS3QNEOtVAd9Bd0oZE0pBEoXyw0YZc_pDsVWZFS4Z0",
                    "likeCount": 1,
                    "nickname": "관리자",
                    "regDate": "2024-01-23T16:03:28.297596",
                    "modifiedDate": null,
                    "deletedDate": null,
                    "cityName": "경기도 수원시",
                    "imgUrl": [
                        "https://traveling7-bucket555.s3.ap-northeast-2.amazonaws.com/3_3_2024-01-23"
                    ],
                    "like": false
                }
            ],
            "pageable": {
                "sort": {
                    "empty": false,
                    "sorted": true,
                    "unsorted": false
                },
                "offset": 0,
                "pageNumber": 0,
                "pageSize": 5,
                "paged": true,
                "unpaged": false
            },
            "totalElements": 6,
            "totalPages": 2,
            "last": false,
            "number": 0,
            "sort": {
                "empty": false,
                "sorted": true,
                "unsorted": false
            },
            "size": 5,
            "numberOfElements": 5,
            "first": true,
            "empty": false
        }
        """
//        guard let jsonData: Data = jsonString.data(using: .utf8) else { return }
//
//        // 최상위 JSON 구조를 매핑하기 위한 구조체
//        
//
//        // JSON 디코딩
//        do {
//            let decoder = JSONDecoder()
//            // Date 형식에 맞게 decoder 설정
//            decoder.dateDecodingStrategy = .iso8601
//            let response = try decoder.decode(Response.self, from: jsonData)
//            let boards = response.content // BoardModel의 배열
//            
//            // boards를 사용하여 필요한 작업 수행
//        } catch {
//            print(error)
//        }
        



        // JSON 인코딩
        let user: User = User(name: "홍길동", age: 24, email: "hong@example.com")
        let encoder: JSONEncoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData: Data = try? encoder.encode(user),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString) // JSON 문자열 출력
        }

        // JSON 디코딩
//        let jsonString = """
//        {
//            "name": "홍길동",
//            "age": 24,
//            "email": "hong@example.com"
//        }
//        """
        if let jsonData: Data = jsonString.data(using: .utf8),
           let user: User = try? JSONDecoder().decode(User.self, from: jsonData) {
            print("이름: \(user.name), 나이: \(user.age), 이메일: \(user.email)")
        }

    }
}

struct User: Codable {
    var name: String
    var age: Int
    var email: String
}
