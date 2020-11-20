//
//  CustomSheetView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-14.
//

import SwiftUI

struct CustomSheetView: View {
    
    @Binding var currentHeight: CGFloat
    @Binding var movingOffset: CGFloat
    @Binding var isShowing: Bool
    @Binding var targetView: TargetView
    @Binding var isLoggedIn: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if self.isShowing {
            SheetView(currentHeight: self.$currentHeight, movingOffset: self.$movingOffset, smallHeight: 300, onDragEnd: { position in
                // Do things on drag End
                self.isShowing = false
            }) {
                ZStack(alignment: .top) {
                    switch targetView {
                    case .SignUp:
                        SignUpView(movingOffset: self.$currentHeight)
                    case .Login:
                        LoginView(movingOffset: self.$currentHeight, isLoggedIn: self.$isLoggedIn)
                    case .None:
                        Text("none")
                    }
                    
                }
                .background(colorScheme == .dark ? Color.black : Color.white)
                .shadow(color: Color.gray.opacity(0.2), radius: 6, x: 0.0, y: -5)
                .cornerRadius(40.0)
            }
        }
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
