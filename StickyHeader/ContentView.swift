//
//  ContentView.swift
//  StickyHeader
//
//  Created by HASAN BERAT GURBUZ on 11.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            HomeView(size: size, safeArea: safeArea)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

#Preview {
    ContentView()
}
