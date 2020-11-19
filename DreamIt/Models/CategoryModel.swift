//
//  CategoryModel.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-21.
//

import Foundation

struct CategoryModel {
    var name: String
    var selected: Bool
    
    init(name: String, selected: Bool) {
        self.name = name
        self.selected = selected
    }
}
