//
//  TeachingView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/13.
//

import SwiftUI

struct TeachingView: View { 
    @State var readPage: Double = 5
    
    
    @Binding var progress_: Int
    var body: some View {
        ZStack {
            Color("Explore")
                .opacity(0.6)
                .ignoresSafeArea()
            VStack {
                Text("Have you ever thought about how the color of light is formed?\nIn color theory, there are two important theories: addition and subtraction. Addition mixing is suitable for the mixing of light, while subtraction mixing is suitable for mixing of pigments.")
                    .font(.system(size: 20))
                Text("1")
                    .font(.system(size: 200))
                Spacer()
            }
            .offset(y: 60)
            .padding( )
            .opacity(readPage == 1 ? 1 : 0)
            
            VStack {
                Text("There are three different types of cone cells in the human eye. The human eye can sense the electromagnetic waves of three wavelengths from red (R), green (G) and blue (B), corresponding to the three colors of R, G, and B, respectively. These cone cells are sensitive to different wavelengths of light.")
                    .font(.system(size: 20))
                
            Text("2")
                .font(.system(size: 200))
                Spacer()
            }
            .offset(y: 60)
            .padding()
            .opacity(readPage == 2 ? 1 : 0)
            
            VStack {
                Text("When they are stimulated by light, they will produce corresponding nerve signals, which are eventually transmitted to the brain through the optic nerve. Therefore, the best three primary colors of light for the human eye are RGB.")
                    .font(.system(size: 20))
                
            Text("3")
                .font(.system(size: 200))
                Spacer()
            }
            .offset(y: 60)
            .padding()
            .opacity(readPage == 3 ? 1 : 0)
            
            VStack {
                Text("The three primary colors of pigment are cyan (C), magenta (M), and yellow (Y). Adding the most commonly used color black (K), these four form a common color. This is what CMYK means. The theory of subtraction is applied when we see the color white that the color absorbed by the pigment is the color presented.")
                    .font(.system(size: 20))
                Spacer()
            }
            .offset(y: 60)
            .padding()
            .opacity(readPage == 4 ? 1 : 0)
            
            VStack {
                Spacer(minLength: 80)
                Text("In short, the two color systems of RGB and CMYK constitute the most commonly used color representation method: \n")
                Divider()
                VStack {
                    VStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.white)
                                .opacity(0.7)
                                .frame(width: 130, height: 50)
                                .overlay(content: {
                                    Text("RGB")
                                        .font(.title)
                                        .bold()
                                })
                        }
                        Text("First, RGB is an additive color system for electronic equipment, such as TV and computer screens. It uses the three colors of red, green, and blue to mix light to create other colors. Combining these colors can create various colors, and mixing all three main colors will produce white. This system starts with darkness, and colors are created by adding light.")
                        
                        Spacer()
                    }
                    VStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.white)
                                .opacity(0.7)
                                .frame(width: 130, height: 50)
                                .overlay(content: {
                                    Text("CMYK")
                                        .font(.title)
                                        .bold()
                                })
                        }
                        Text("Second, CMYK is a subtraction color system for printing. It mixes cyan (C), magenta (M), yellow (Y), and black (K) pigments or inks to create other colors. Each color absorbs part of the light and only reflects part of it. We only see the reflected color. Mixing all three colors will produce black. This system starts with white, and the color is created by reducing light.")
                        
                        Spacer()
                    }
                }
                
            }
            .padding()
            .opacity(readPage == 5 ? 1 : 0)
            
            VStack {
                Text("Now, let's dive in to study how to mix pigments and light in practical applications to create the color effects we want!")
                    .font(.system(size: 20))
                Spacer()
            }
            .offset(y: 60)
            .padding()
            .opacity(readPage == 6 ? 1 : 0)
            
            
            nextView()
            prevView()
        }
    }
    
    @State private var next_: Int = 0
    func nextView() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.readPage += 1.0
                    
                    if self.readPage == 7 {
                        self.progress_ = 0
                        self.readPage = 1
                    }
                    next_ += 1;
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .frame(width: 70, height: 70)
                        Image(systemName: "timelapse", variableValue: readPage / 6)
                            .font(.system(size: 50, weight: .black))
                            .animation(.easeIn, value: readPage)
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
                    self.readPage = max(self.readPage - 1.0, 1)
                    prev_ += 1
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
    
}

#Preview {
    ContentView(prograss_: 1)
}

