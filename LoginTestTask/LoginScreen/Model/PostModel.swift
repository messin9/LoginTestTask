//
//  PostModel.swift
//  LoginTestTask
//
//  Created by Алексей Мотин on 17.10.2021.
//
import Foundation

// MARK: - Welcome
struct PostData: Codable {
    let success: String
    let response: PostResponse
}

// MARK: - Response
struct PostResponse: Codable {
    let token: String
}
