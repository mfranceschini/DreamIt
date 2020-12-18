//
//  CategoryBubble.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-15.
//

import SwiftUI

struct CategoryBubble: View {
    
    @Binding var categories: [CategoryModel]
    @Binding var ideaList: [IdeaItemModelView]
    @Binding var loading: Bool
    
    var body: some View {
        ForEach(0..<categories.count) { index in
            Button(categories[index].name) {
                withAnimation(.linear(duration: 0.1)) {
                    loading.toggle()
                    categories[index].selected.toggle()
                    categories.sort { ($0.name < $1.name) }
                    categories.sort { ($0.selected && !$1.selected) }
//                    let initialLength = self.ideaList.count
//                    let temp = self.ideaList.filter { idea in idea.category == categories[index].id }
//                    for _ in 1...initialLength {
//                        self.ideaList.removeFirst()
//                    }
//                    temp.forEach { item in self.ideaList.append(item) }
                    loading.toggle()
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
