//
//  GetModel.swift
//  LoginTestTask
//
//  Created by Алексей Мотин on 17.10.2021.
//

import Foundation

// MARK: - Getdata
struct GetData: Codable {
    let success: String
    let response: [Payment]
}

// MARK: - Response
struct Payment: Codable {
    let amount: Amount
    let currency: String?
    let created: Int
    let desc: String
}

enum Amount: Codable {
    case double(Double)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Amount.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Amount"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
