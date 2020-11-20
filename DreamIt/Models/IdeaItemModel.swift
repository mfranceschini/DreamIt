//
//  DreamItemModel.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-21.
//

import SwiftUI

struct IdeaItemModel: Hashable {
    var title: String
    var author: String
    var createdAt: Date
    var impressions: Int
    var liked: Bool
    var thumbnail: UIImage
    var category: Int
    
    public init(category: Int, title: String, author: String, createdAt: Date, impressions: Int, liked: Bool, thumbnail: UIImage) {
        self.category = category
        self.title = title
        self.author = author
        self.createdAt = createdAt
        self.impressions = impressions
        self.liked = liked
        self.thumbnail = thumbnail
    }
}
