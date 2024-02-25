//
//  ContentView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/11.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var prograss_ = 0
    
    @State private var showMe: Bool = false
    @State private var pigmentDifficulty: Bool = false
    @State private var lightDifficulty: Bool = false
    
    @State private var test: Bool = false
    private let aboutMeTip = AboutMeTip()
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack{
                    Image("Img 3")
                        .resizable()
                        .frame(width: 400, height: 400)
                        .offset(x: -20, y: 40)
                    Spacer()
                    
                    Button(action: {self.prograss_ = 1}, label: {
                        introTeachingView()
                    })
                    Button(action: {self.prograss_ = 2; pigmentDifficulty = true}, label: {
                        introPigmentView()
                    })
                    Button(action: {self.prograss_ = 3; lightDifficulty = true}, label: {
                        introLightView()
                    })
                }
                .buttonStyle(.plain)
                .tabViewStyle(.page)
                .opacity(prograss_ <= 0 ? 1 : 0)
                .animation(.spring.speed(2), value: prograss_)
            }
            NewTeachingView(progress_: $prograss_)
                .opacity(prograss_ == 1 ? 1 : 0)
                .animation(.spring.speed(2), value: prograss_)
            
            PigmentView(selectDifficulty: $pigmentDifficulty, selection: $prograss_)
                .opacity(prograss_ == 2 ? 1 : 0)
                .animation(.spring.speed(2), value: prograss_)
            
            LightView(selectDifficulty: $lightDifficulty, selection: $prograss_)
                .opacity(prograss_ == 3 ? 1 : 0)
                .animation(.spring.speed(2), value: prograss_)
            
            
            TrailView(selection: $prograss_)
                .opacity(prograss_ == -1 ? 1 : 0)
                .animation(.spring.speed(2), value: prograss_)
            
            
            homeButton()
        }
        .sheet(isPresented: $showMe, content: {
            AboutMeView()
                .presentationDetents([.height(500)])
        })
    }
    
    func homeButton() -> some View {
        VStack {
            HStack {
                Button(action: {
                    if prograss_ >= 1 {
                        prograss_ = 0
                    } else {
                        showMe = true
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .frame(width: 70, height: 70)
                        
                        if prograss_ == 0 {
                            Circle()
                                .fill(.white)
                                .stroke(.gray, style: .init(lineWidth: 3))
                                .frame(width: 40)
                                
                        }
                        
                        Image(systemName:  prograss_ == 0 ? "circle.fill" : "house.fill")
                            .contentTransition(
                                .symbolEffect(.replace.downUp.byLayer)
                            )
                            .font(.system(size: 30))
                            .tint(.black)
                        
                    }
                })
                .padding(.horizontal)
                .popoverTip(aboutMeTip, arrowEdge: .top)
                Spacer()
            }
            
            Spacer()
        }
    }
}

struct AboutMeTip: Tip {
    @Parameter
    static var isShowing: Bool = true
    
    var title: Text {
        Text("About Me")
    }
    
    
    var message: Text? {
        Text("Click Here to see this app")
    }
    
    
    var image: Image? {
        Image(systemName: "sun.min.fill")
    }
    
    
    var rules: [Rule] {
        [
            #Rule(Self.$isShowing) {
                $0 == true
            }
        ]
    }
}

#Preview {
    
    ContentView()
}
