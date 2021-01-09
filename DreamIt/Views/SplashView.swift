//
//  SplashView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-10.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    @State var moveLogo: Bool = false
    @State var scale: CGFloat = 0.5
    @State private var firstPlane: Bool = true
    @Environment(\.colorScheme) var colorScheme
    
    @State private var background1: [Color] = [
        Color(red: 0.37, green: 0.22, blue: 0.56),
        Color(red: 0.61, green: 0.31, blue: 0.62),
        Color(red: 0.95, green: 0.49, blue: 0.71),
        Color(red: 1.00, green: 0.42, blue: 0.44),
        Color(red: 0.96, green: 0.44, blue: 0.24)
    ]
    @State private var background2: [Color] = [
        Color(red: 0.96, green: 0.44, blue: 0.24),
        Color(red: 1.00, green: 0.42, blue: 0.44),
        Color(red: 0.95, green: 0.49, blue: 0.71),
        Color(red: 0.61, green: 0.31, blue: 0.62),
        Color(red: 0.37, green: 0.22, blue: 0.56),
    ]
    
    func setGradient(gradient: [Color]) {
        if firstPlane {
            background2 = gradient
        }
        else {
            background1 = gradient
        }
        firstPlane = !firstPlane
    }
    
    var body: some View {
        VStack {
            if self.isActive {
                ContentView()
            } else {
                ZStack {
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: self.background1), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? background2 : background1), startPoint: UnitPoint(x: 1, y: 1), endPoint: UnitPoint(x: 0, y: 0)))
                        .opacity(self.firstPlane ? 0 : 1)
                    VStack(alignment: .center) {
                        Image("DreamItLogo_inApp")
                            .resizable()
                            .modifier(AppLogoStyle())
                        Text("DreamIt")
                            .font(Font.largeTitle)
                            .kerning(2.0)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        if self.moveLogo {
                            Spacer()
                        }
                    }
                    .padding(.top, self.moveLogo ? 37 : 0)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.easeIn) {
                            self.scale = 1
                        }
                    }
                }
                .ignoresSafeArea()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    self.setGradient(gradient: [Color(red: 0.61, green: 0.31, blue: 0.62), Color(red: 1.00, green: 0.42, blue: 0.44)])
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    self.setGradient(gradient: colorScheme == .dark ? background2 : background1)
                    self.moveLogo = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.spring()) {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
