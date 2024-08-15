//
//  InfoModel.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//

import Foundation

struct InfoModel: Codable {
    let response: Res?
}
struct Res: Codable {
    let id: Int?
    let first_name, last_name: String?
}
