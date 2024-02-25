//
//  TrailView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/13.
//

import SwiftUI

struct TrailView: View {
    let gradientSurface = LinearGradient(colors: [.white.opacity(0.1), .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
    @Binding var selection: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .foregroundStyle(gradientSurface)
                .background(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .stroke(lineWidth: 1.5)
                        .foregroundStyle(.ultraThinMaterial)
                        .opacity(0.8)
                )
                .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 8)
                .opacity(selection == -1 ? 1 : 0)
                .animation(.spring, value: selection)
            ScrollView {
                VStack(alignment: .center) {
                    Text("Hello !✨")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                    Text("This is an app that teaches you the differences between mixing colors and light. The app consists of three pages. The first page is for explanation, the second page is a color mixing game, and the third page is a light mixing game.")
                        .font(.system(size: 30, design: .serif))
                    Button(action: {
                        self.selection = 0
                    }, label: {
                        Text("Enter")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
