//
//  Get.swift
//  LoginTestTask
//
//  Created by Алексей Мотин on 17.10.2021.
//

import Foundation

struct testGet: DataRequest {
    
    var body: Data?
    
    typealias Response = GetData
    
    var token: String?
    
    var url: String {
        let baseURL: String = "http://82.202.204.94/api-test"
        let path: String = "/payments"
        return baseURL + path
    }
    
    var headers: [String : String] {
        [
            "app-key":"12345",
            "v":"1"
        ]
        
    }
    
    var queryItems: [String : String] {
        ["token":"\(token ?? "")"]
//        ["token":"123456789"]
    }
    
    var method: HTTPMethod {
        .get
    }
}
