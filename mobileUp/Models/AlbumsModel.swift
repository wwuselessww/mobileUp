//
//  AlbumsModel.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 17.08.24.
//

import Foundation

struct AlbumsModel: Codable {
    let response: AlbumResponse
}

struct AlbumResponse: Codable {
    let count: Int
    let items: [Item]
}

struct Item: Codable {
    let id, owner_id, size: Int
    let title: String
    let created: Int
    let description: String
    let thumb_id, updated: Int
}
