//
//  introPigmentView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/13.
//

import SwiftUI

struct introPigmentView: View {
    var body: some View {
        ZStack {
            Image("PinkBall")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Rectangle())
                .offset(x:130, y: 0)
            
            Image("PinkBall")
                .resizable()
                .frame(width: 100, height: 100)
                .scaleEffect(1.6)
                .offset(x:163, y:-50)
                .allowsHitTesting(false)
            
            HStack{
                Text("Pigment")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 36, weight: .bold, design: .default))
                    .offset(x: 20, y: -20)
                Spacer()
            }
            Image(systemName: "gamecontroller.fill")
                .font(.system(size: 20))
                .symbolEffect(.pulse.byLayer)
                .rotationEffect(.degrees(30))
                .offset(x: 160, y: -30)
        }
        .background(Color("Pigment"))
        .mask({
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
        })
        .frame(height: 100)
        .padding(.horizontal)
    }
}

#Preview {
    ContentView(prograss_: 0)
}
