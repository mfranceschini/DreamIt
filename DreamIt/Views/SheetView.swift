//
//  SheetView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-14.
//

import SwiftUI

enum Position {
    case up
    case down
}

struct SheetView<Content>: View where Content: View {
    
    @Binding var currentHeight: CGFloat
    @Binding var movingOffset: CGFloat
    var position = Position.up
    var smallHeight: CGFloat = 50
    var onDragEnd: ((_ position: Position)->()) = {_ in }
    var content: () -> Content
    
    var body: some View {
        Group(content: self.content)
            .frame(minHeight: 0.0, maxHeight: .infinity, alignment: .bottom)
            .offset(y: self.movingOffset)
            .gesture(
                DragGesture().onChanged({ drag in
                    if self.movingOffset >= 0 {
                        self.movingOffset =  drag.translation.height  + self.currentHeight
                    }
                }).onEnded({ drag in
                    withAnimation( .spring(dampingFraction: 0.7) ) {
                        if  self.movingOffset > -50 {
                            self.movingOffset = 0.0
                        }
                        
                        if drag.translation.height > 80 {
                            self.movingOffset =  self.smallHeight
                            self.onDragEnd(.down)
                        }
                        self.currentHeight = self.movingOffset
                    }
                })
            )
    }
    
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(currentHeight: .constant(0.0), movingOffset: .constant(0.0)) {
            Rectangle().foregroundColor(Color.white).frame(height: 500)
        }
    }
}
