//
//  VideoModel.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 18.08.24.
//

import Foundation

// MARK: - InfoModel
struct VideoModel: Codable {
    let response: VideoResponse
}

// MARK: - Response
struct VideoResponse: Codable {
    let count: Int
    let items: [VideoItem]
}

// MARK: - Item
struct VideoItem: Codable {
    let adding_date: Int
    let date: Int
    let description: String
    let duration: Int
    let image: [FirstFrame]
    let first_frame: [FirstFrame]?
    let width, height: Int?
    let id, owner_id: Int
//    let ov_id: String?
    let title: String
    let player: String
    let added: Int
    let platform: String?
}

// MARK: - FirstFrame
struct FirstFrame: Codable {
    let url: String
    let width, height: Int
    let with_padding: Int?

}



