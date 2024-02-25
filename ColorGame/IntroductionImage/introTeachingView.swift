//
//  introTeachingView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/13.
//

import SwiftUI

struct introTeachingView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("Explore"))
            
            Image("BlueBall")
                .resizable()
                .frame(width: 100, height: 100)
                .scaleEffect(1.6)
                .offset(x:163, y:60)
            
            Image("BlueBall")
                .resizable()
                .frame(width: 100, height: 100)
                .scaleEffect(1.2)
                .offset(x:-60, y:-40)
            
            HStack{
                Text("Explore")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 36, weight: .bold, design: .default))
                    .offset(x: 20, y: -20)
                Spacer()
            }
            Image(systemName: "book.pages.fill")
                .font(.system(size: 20))
                .symbolEffect(.pulse.byLayer)
                .rotationEffect(.degrees(30))
                .offset(x: 160, y: -30)
        }
        .mask({
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
        })
        .frame(height: 100)
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
