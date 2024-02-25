//
//  introLightView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/13.
//

import SwiftUI

struct introLightView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("Light"))
            /*
            VStack {
                Image(systemName: "lightspectrum.horizontal")
                    .font(.system(size: 200))
                    .rotationEffect(.degrees(30))
                    .opacity(0.3)
            }
            VStack {
                Image(systemName: "lightspectrum.horizontal")
                    .font(.system(size: 100))
            }*/

            
            Image(systemName: "gamecontroller.fill")
                .font(.system(size: 20))
                .symbolEffect(.pulse.byLayer)
                .rotationEffect(.degrees(30))
                .offset(x: 160, y: -30)
            
            Image("YellowBall")
                .resizable()
                .frame(width: 100, height: 100)
                .scaleEffect(2.2)
                .offset(x: -140, y: 50)
            
            Image("YellowBall")
                .resizable()
                .frame(width: 70, height: 70)
                .offset(x:80, y: 40)
            
            HStack{
                Text("Light")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 36, weight: .bold, design: .default))
                    .offset(x: 20, y: -20)
                Spacer()
            }
            
        }
        .mask({
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
        })
        .frame(height: 100)
        .padding(.horizontal)
    }
}

#Preview {
    introLightView()
}
