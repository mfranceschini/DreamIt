//
//  DreamItemModel.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-21.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct IdeaItemModel: Hashable {
    var id: String
    var title: String
    var author: String
    var createdAt: String
    var impressions: Int
    var liked: Bool
    var category: Int
    var description: String
    
    public init(id: String, category: Int, title: String, author: String, createdAt: String, impressions: Int, liked: Bool, description: String) {
        self.id = id
        self.category = category
        self.title = title
        self.author = author
        self.createdAt = createdAt
        self.impressions = impressions
        self.liked = liked
        self.description = description
    }
}
