//
//  ScrollDetector.swift
//  StickyHeader
//
//  Created by HASAN BERAT GURBUZ on 11.10.2024.
//

import SwiftUI

struct ScrollDetector: UIViewRepresentable {

    // MARK: - PROPERTIES

    var onScroll: (CGFloat) -> ()
    var onDraggingEnd: (CGFloat, CGFloat) -> ()

    // MARK: - FUNCTIONS

    func makeCoordinator() -> ScrollCoordinator {
        return ScrollCoordinator(parent: self)
    }

    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView {
                scrollView.delegate = context.coordinator
                context.coordinator.isDelegateAdded = true
            }
        }
    }
}

// MARK: - SCROLLCOORDINATOR

final class ScrollCoordinator: NSObject, UIScrollViewDelegate {

    // MARK: - PROPERTIES

    var parent: ScrollDetector
    var isDelegateAdded: Bool = false

    // MARK: - INIT

    init(parent: ScrollDetector) {
        self.parent = parent
    }

    // MARK: - FUNCTIONS

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        parent.onScroll(scrollView.contentOffset.y)
    }
}
