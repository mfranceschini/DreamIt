//
//  Loading.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-19.
//

import SwiftUI

struct Loading: View {
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State var leftOffset: CGFloat = -30
    @State var rightOffset: CGFloat = 30
    let shapeColor = Color.white
    let opacity = 0.9
    
    var body: some View {
        ZStack {
            Circle()
                .fill(shapeColor)
                .frame(width: 20, height: 20)
                .offset(x: leftOffset)
                .opacity(opacity)
                .animation(Animation.easeInOut(duration: 0.5))
            Circle()
                .fill(shapeColor)
                .frame(width: 20, height: 20)
                .offset(x: leftOffset)
                .opacity(opacity)
                .animation(Animation.easeInOut(duration: 0.4).delay(0.1))
            Circle()
                .fill(shapeColor)
                .frame(width: 20, height: 20)
                .offset(x: leftOffset)
                .opacity(opacity)
                .animation(Animation.easeInOut(duration: 0.4).delay(0.2))
        }
        .onReceive(timer) { (_) in
            swap(&self.leftOffset, &self.rightOffset)
        }
    }
    
}
