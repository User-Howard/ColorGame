//
//  NewTeachingView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/21.
//

import SwiftUI

struct NewTeachingView: View {
    @Binding var progress_: Int
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            TabView(selection:$selection) {
                ZStack {
                    blueCircle()
                        .frame(width: 100)
                        .offset(x:-80, y:-70)
                    blueCircle()
                        .frame(width: 350)
                        .scaleEffect(1.2)
                        .offset(x:200, y:250)
                    
                    VStack {
                        Text(content[0])
                            .font(.system(size: 20))
                        Spacer()
                    }
                }
                .offset(y: 60)
                .padding()
                .tag(0)
                
                
                ZStack {
                    blueCircle()
                        .frame(width: 350)
                        .scaleEffect(1.2)
                        .offset(x:200-UIScreen.main.bounds.width, y:250)
                    
                    
                    blueCircle()
                        .frame(width: 200)
                        .offset(x:180, y:-250)
                    VStack {
                        Text(content[1])
                            .font(.system(size: 20))
                        
                        Spacer()
                    }
                }
                .offset(y: 60)
                .padding()
                .tag(1)
                
                ZStack{
                    blueCircle()
                        .frame(width: 200)
                        .offset(x:180-UIScreen.main.bounds.width, y:-250)
                    
                    blueCircle()
                        .frame(width: 160)
                        .offset(x: 140, y:-50)
                    blueCircle()
                        .frame(width: 160)
                        .offset(x: -60, y:150)
                    blueCircle()
                        .frame(width: 90)
                        .offset(x: -110, y:110)
                    VStack {
                        Text(content[2])
                            .font(.system(size: 20))
                        
                        Spacer()
                    }
                }
                .offset(y: 60)
                .padding()
                .tag(2)
                
                ZStack{
                    blueCircle()
                        .frame(width: 160)
                        .offset(x: 140-UIScreen.main.bounds.width, y:-50)
                    VStack(spacing: 18) {
                        showColorBlend(A: Color(red: 1, green: 1, blue: 0),
                                       B: Color(red: 1, green: 0, blue: 1),
                                       equal: Color(red: 1, green: 0, blue: 0))
                        showColorBlend(A: Color(red: 1, green: 0, blue: 1),
                                       B: Color(red: 0, green: 1, blue: 1),
                                       equal: Color(red: 0, green: 0, blue: 1))
                        showColorBlend(A: Color(red: 0, green: 1, blue: 1),
                                       B: Color(red: 1, green: 1, blue: 0),
                                       equal: Color(red: 0, green: 1, blue: 0))
                    }
                    .offset(y:80)
                    VStack {
                        Text(content[3])
                            .font(.system(size: 20))
                        
                        Spacer()
                    }
                }
                .offset(y: 60)
                .padding()
                .tag(3)
                
                VStack {
                    Text(content[4])
                    Divider()
                    VStack {
                        VStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white)
                                    .opacity(0.7)
                                    .frame(width: 130, height: 50)
                                    .overlay(content: {
                                        Text("RGB")
                                            .font(.title)
                                            .bold()
                                    })
                            
                            Text(content[5])
                            
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white)
                                    .opacity(0.7)
                                    .frame(width: 130, height: 50)
                                    .overlay(content: {
                                        Text("CMYK")
                                            .font(.title)
                                            .bold()
                                    })
                            
                            Text(content[6])
                            
                            Spacer()
                        }
                    }
                    
                }
                .offset(y: 60)
                .padding()
                .tag(4)
                
                ZStack {
                    VStack {
                        Text(content[7])
                            .font(.system(size: 20))
                        Spacer()
                    }
                    Image("FamilyBall")
                        .resizable()
                        .frame(width: 200, height: 300, alignment: .leading)
                        .scaleEffect(2.2)
                        .offset(y:60)
                }
                .offset(y: 60)
                .padding()
                .tag(5)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Color("Explore").opacity(0.5))
            .ignoresSafeArea()
            
            nextView()
    
            prevView()
                .opacity(selection != 0 ? 1 : 0)
                .animation(.bouncy, value: selection)
        }
        .onAppear {
            selection = 0
            print("enter teachingView")
        }
    }
    func blueCircle() -> some View {
        ZStack {
            Circle()
                .fill(.white)
            Circle()
                .fill(Color("ColorBall").opacity(0.8))
                .stroke(.blue, style: .init(lineWidth: 1))
        }
    }
    func showColorBlend(A: Color, B: Color, equal: Color) -> some View {
        HStack(spacing: 18) {
            whiteBorderColorBall(color: A)
            Image(systemName: "plus")
                .font(.system(size: 30, weight: .bold))
            whiteBorderColorBall(color: B)
            Image(systemName: "equal")
                .font(.system(size: 30, weight: .bold))
            whiteBorderColorBall(color: equal)
        }
    }
    func whiteBorderColorBall(color: Color) -> some View {
        VStack {
            Circle()
                .fill(color)
                .stroke(.white, style: .init(lineWidth: 10))
                .frame(width: 70)
        }
    }
    @State private var next_: Int = 0
    func nextView() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    if selection == 5 {
                        progress_ = 0
                        selection = 0
                    } else {
                        withAnimation {
                            selection += 1
                        }
                    }
                    next_ += 1;
                    print(selection)
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .frame(width: 70, height: 70)
                        Image(systemName: "timelapse", variableValue: Double(selection) / 5)
                            .font(.system(size: 50, weight: .black))
                            .animation(.easeIn, value: selection)
                        Image(systemName: "chevron.forward")
                            .font(.system(size: 20, weight: .black, design: .default))
                            .symbolEffect(.bounce, value: next_)
                    }
                })
                .tint(.black)
                .padding()
                .buttonStyle(.plain)
            }
        }
    }
    
    @State private var prev_: Int = 0
    func prevView() -> some View {
        HStack {
            VStack {
                Spacer()
                Button(action: {
                    if selection >= 0 {
                        withAnimation {
                            selection -= 1
                        }
                        prev_ += 1
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .frame(width: 70, height: 70)
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 20, weight: .black, design: .default))
                            .symbolEffect(.bounce, value: prev_)
                    }
                })
                .padding()
                .tint(.black)
                
                .buttonStyle(.plain)
            }
            Spacer()
        }
    }
    
    let content: [String] = [
        "Have you ever thought about how the color of light is formed?\nIn color theory, there are two important theories: addition and subtraction. Addition mixing is suitable for the mixing of light, while subtraction mixing is suitable for mixing of pigments.",
        "There are three different types of pyramidal cells in the human eye. The human eye can sense the electromagnetic waves of three wavelengths from red (R), green (G) and blue (B), corresponding to the three colors of R, G, and B, respectively. These pyramidal cells are sensitive to different wavelengths of light.",
        "When they are stimulated by light, they will produce corresponding nerve signals, which are eventually transmitted to the brain through the optic nerve. Therefore, the best three primary colors of light for the human eye are RGB.",
        "The three primary colors of pigment are cyan (C), magenta (M), and yellow (Y). Adding the most commonly used color black (K), these four form a common color. This is what CMYK means. The theory of subtraction is applied when we see the color that the color absorbed by the pigment is the color presented.",
        "In short, the two color systems of RGB and CMYK constitute the most commonly used color representation method:",
        "First, RGB is an additive color system for electronic equipment, such as TV and computer screens. It uses the three colors of red, green, and blue to mix light to create other colors. Combining these colors can create various colors, and mixing all three main colors will produce white. This system starts with darkness, and colors are created by adding light.",
        "Second, CMYK is a subtraction color system for printing. It mixes cyan (C), magenta (M), yellow (Y), and black (K) pigments or inks to create other colors. Each color absorbs part of the light and only reflects part of it. We only see the reflected color. Mixing all three colors will produce black. This system starts with white, and the color is created by reducing light.",
        "Now, let's dive in to study how to mix pigments and light in practical applications to create the color effects we want!"
    ]
}

#Preview {
    // NewTeachingView()
    ContentView(prograss_: 1)
}
