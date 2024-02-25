//
//  AboutMeView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/17.
//

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About this App")
                .font(.title)
                .bold()
            Text("Sometimes I go outdoors to sketch, but I only have simple paints on hand. I then need to use a few pigments to make more colors to capture the beautiful scenery. However, I always cannot get the exact colors I want if I mix them randomly.")
            
            Text("After the rain, there are often rainbows in the distant sky. And I would wonder why the light has so many colors? Because of my love of colors I see everywhere, I want to design a game app, so that kids can create new colors by mixing different colors. With this app, kids can mix different colors of light and produce another color of light. At the same time, this app has valuable educational elements that kids can learn while playing and improve their knowledge and creativity of color.")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AboutMeView()
}
