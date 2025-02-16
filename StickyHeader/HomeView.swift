//
//  HomeView.swift
//  StickyHeader
//
//  Created by HASAN BERAT GURBUZ on 11.10.2024.
//

import SwiftUI

struct HomeView: View {

    // MARK: - PROPERTIES

    @State private var offsetY: CGFloat = 0
    var size: CGSize
    var safeArea: EdgeInsets

    // MARK: - BODY
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HeaderView()
                    .zIndex(1000)
                DemoCardListView()
                    .padding(.horizontal)
            }
            .background {
                ScrollDetector { offset in
                    offsetY = -offset
                } onDraggingEnd: { offset, velocity in
                    
                }
            }
        }
    }

    // MARK: - PRIVATE VIEW FUNCTIONS

    @ViewBuilder
    private func HeaderView() -> some View {
        let headerHeight = (size.height * 0.4) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        ZStack {
            Rectangle().fill(.black)
            VStack(spacing: 5) {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    let halfScaleHeight = (rect.height * 0.5) * 0.5
                    let midY = rect.midY
                    let bottomPadding: CGFloat = 15
                    let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaleHeight - bottomPadding))
                    Image("profile")
                        .resizable()
                        .clipShape(.circle)
                        .scaleEffect(1 - (progress * 0.7), anchor: .leading)
                        .offset(x: -(rect.minX - 15) * progress, y: -resizedOffsetY * progress)
                }
                .frame(width: headerHeight * 0.5, height: headerHeight * 0.5)
                Text("Hasan Gürbüz")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .scaleEffect(1 - (progress * 0.5))
                    .offset(y: -4.5 * progress)
                Text("iOS Developer")
                    .foregroundStyle(.white.opacity(0.5))
                    .scaleEffect(1 - (progress * 0.5))
                    .offset(y: -4.5 * progress)
            }
            .padding(.top, safeArea.top)
            .padding(.bottom, 15)
        }
        .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY), alignment: .bottom)
        .offset(y: -offsetY)
    }

    private func DemoCardListView() -> some View {
        VStack(spacing: 10) {
            ForEach(1...25, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.black.opacity(0.05))
                    .frame(height: 80)
            }
        }
    }
}

// MARK: - PREVIEW

#Preview {
    ContentView()
}
