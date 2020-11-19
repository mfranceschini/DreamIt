//
//  CategoryBubble.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-15.
//

import SwiftUI

struct CategoryBubble: View {
    
    var categories: [CategoryModel]
    
    var body: some View {
        ForEach(0..<categories.count) { index in
            Text(categories[index].name)
                .foregroundColor(categories[index].selected ? Color.white : Color.white)
                .font(.callout)
                .frame(width: 110, height: 35)
                .background(categories[index].selected ? Color.blue : Color(UIColor.lightGray))
                .shadow(color: Color.gray,
                        radius: 5.0,
                        x: 1,
                        y: 1)
                .clipShape(Capsule())
        }
        
    }
}
