//
//  CategoryModel.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-21.
//

import Foundation

struct CategoryModel {
    var id: Int
    var name: String
    var selected: Bool
    
    init(id: Int, name: String, selected: Bool) {
        self.id = id
        self.name = name
        self.selected = selected
    }
}
