//
//  SheetPresenter.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-10.
//

import SwiftUI

struct SheetPresenter<Content, Parent>: View where Content: View, Parent: View {
    @Binding var presentingSheet: Bool
    var content: Content
    var parent: Parent
    var body: some View {
        EmptyView()
            .background(Color.clear)
            .sheet(isPresented: self.$presentingSheet, content: { self.content })
            .onAppear {
                DispatchQueue.main.async {
                    self.presentingSheet = true
                }
            }
    }
}
