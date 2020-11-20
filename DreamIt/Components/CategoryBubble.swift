//
//  CategoryBubble.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-15.
//

import SwiftUI

struct CategoryBubble: View {
    
    @Binding var categories: [CategoryModel]
    
    var body: some View {
        ForEach(0..<categories.count) { index in
            Button(categories[index].name) {
                withAnimation(.linear(duration: 0.1)) {
                    categories[index].selected.toggle()
                }
            }
            .foregroundColor(categories[index].selected ? Color.white : Color.white)
            .font(categories[index].selected ? Font.callout.bold() : Font.callout)
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
