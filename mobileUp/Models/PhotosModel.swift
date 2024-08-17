//
//  PhotosModel.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 17.08.24.
//

import Foundation

// MARK: - InfoModel
struct PhotosModel: Codable {
    let response: PhotosResponse
}

// MARK: - Response
struct PhotosResponse: Codable {
    let count: Int
    let items: [PhotosItem]
    let next_from: String
}

// MARK: - Item
struct PhotosItem: Codable {
    let album_id, date, id, owner_id: Int
    let sizes: [OrigPhoto]
    let text: String
    let user_id: Int
    let web_view_token: String
    let has_tags: Bool
    let orig_photo: OrigPhoto
}

// MARK: - OrigPhoto
struct OrigPhoto: Codable {
    let height: Int
    let type: String
    let url: String
    let width: Int
}
