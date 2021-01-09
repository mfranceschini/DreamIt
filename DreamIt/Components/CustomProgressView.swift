//
//  CustomProgressView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-01-08.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .padding(.top, -45)
    }
}
