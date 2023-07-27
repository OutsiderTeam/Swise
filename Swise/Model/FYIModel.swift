//
//  FYIModel.swift
//  Swise
//
//  Created by Agfid Prasetyo on 26/07/23.
//

import Foundation

struct FYIModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let shortDesc: String
    let image: String
    let desc: [TextModel]
}

struct TextModel: Identifiable, Codable, Hashable {
    var id = UUID()
    let content: String
    let styling: String
}
