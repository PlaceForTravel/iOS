//
//  API.swift
//  TravelApp
//
//  Created by JDeoks on 3/12/24.
//

import Foundation

enum MyMethod: String {
    case get = "GET"
    case post = "POST"
}

class API {
    var path: String
    var method: MyMethod
    var query: [String: String]?
    var body: [String: Any]?
    var header: [String: String]?
    
    init(path: String, method: MyMethod, query: [String : String]? = nil, body: [String : Any]? = nil, header: [String : String]? = nil) {
        self.path = path
        self.method = method
        self.query = query
        self.body = body
        self.header = header
    }
}

class APIManager {
    var apiList: Array<API> = []
    
    init() {
        apiList.append(API(path: "/user/nickname",
                           method: .get,
                           body: ["test": "value"]))
    }
}
