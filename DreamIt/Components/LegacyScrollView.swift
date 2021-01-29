//
//  LegacyScrollView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-01-28.
//

import Foundation
import UIKit
import SwiftUI

struct LegacyScrollView : UIViewRepresentable {

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action:
            #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)

        // Simply to give some content to see in the app
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.text = "Scroll View Content"
        control.addSubview(label)

        return control
    }


    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // code to update scroll view from view state, if needed
    }

    class Coordinator: NSObject {
        var control: LegacyScrollView

        init(_ control: LegacyScrollView) {
            self.control = control
        }

        @objc func handleRefreshControl(sender: UIRefreshControl) {
            // handle the refresh event

            sender.endRefreshing()
        }
    }
}
