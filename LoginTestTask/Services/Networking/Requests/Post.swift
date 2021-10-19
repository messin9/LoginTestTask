//
//  Post.swift
//  LoginTestTask
//
//  Created by Алексей Мотин on 17.10.2021.
//
import Foundation

struct testPost: DataRequest {
    
    var login: String?
    var password: String?
    
    typealias Response = PostData
    
    var url: String {
        let baseURL: String = "http://82.202.204.94/api-test"
        let path: String = "/login"
        return baseURL + path
    }
    
    var headers: [String : String] {
        [
            "app-key":"12345",
            "v":"1"
        ]
        
    }
    
    var queryItems: [String : String] {
        [:]
    }
    
    var body: Data? {
        "login=\(login ?? "")&password=\(password ?? "")".data(using: .utf8)
    }
    
    var method: HTTPMethod {
        .post
    }
}
