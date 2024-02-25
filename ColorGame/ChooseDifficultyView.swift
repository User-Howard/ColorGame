//
//  ChooseDifficultyView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/14.
//

import SwiftUI

struct ChooseDifficultyView: View {
    @Binding var A: Double
    @Binding var startSelect: Bool
    let Difficulty: [String] = ["EASY", "NORMAL", "HARD"]
    var color: Color = Color("Light")
    var body: some View {
        ZStack {
            color
                .ignoresSafeArea()
            VStack {
                Text("EASY")
                    .font(.system(size: 60, weight: .bold))
                    .opacity(abs(A - 0) < 0.5 ? 1 : 0.3)
                    .offset(y: 0)
                Text("NORMAL")
                    .font(.system(size: 60, weight: .bold))
                    .opacity(abs(A - 1) < 0.5 ? 1 : 0.3)
                Text("HARD")
                    .font(.system(size: 60, weight: .bold))
                    .opacity(abs(A - 2) < 0.5 ? 1 : 0.3)
                DifficultySlider(value: $A, color: color)
                    .frame(width: 200, height: 10)
                    .padding(.vertical, 35)
                    .offset(y: -10)
                okButton()
            }

        }
        
    }
    
    func okButton() -> some View {
        Button(action: {
            self.startSelect = false
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: .infinity)
                    .fill(.white)
                    .frame(width: 200, height: 80)
                if color == Color("Pigment") {
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(.pink.opacity(0.3))
                        .frame(width: 190, height: 70)
                } else {
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(color.opacity(0.3))
                        .frame(width: 190, height: 70)
                }
                Text("OK")
                    .font(.system(size: 40, weight: .bold))
            }
        })
        .buttonStyle(.plain)
    }
}
struct DifficultySlider: View {
    @Binding var value: Double
    var color: Color
    let to_: Double = 2
    let step_: Double = 1
    
    
    
    @State private var position = CGSize.zero
    @State private var dragOffset = CGSize.zero
    
    
    var body: some View {
        VStack {
                ZStack(alignment: .center) {
                    /*
                    Rectangle()
                        .foregroundColor(Color.gray)
                        .frame(width: geometry.size.width, height: 2)
                    */
                    
                    // 底色
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(.white)
                        .frame(width: 240, height: 60)
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(.gray.opacity(0.4))
                        .frame(width: 220, height: 40)
                    
                    
                    // 節點
                    Circle()
                        .fill(Color.gray)
                        .frame(height: 20) // 调整刻度的高度
                        .offset(x: 0)
                    Circle()
                        .fill(Color.gray)
                        .frame(height: 20) // 调整刻度的高度
                        .offset(x: -90)
                    Circle()
                        .fill(Color.gray)
                        .frame(height: 20) // 调整刻度的高度
                        .offset(x: 90)
                    
                    
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(height: 80)
                        Circle()
                            .fill(color == Color("Pigment") ? .pink.opacity(0.7) : color.opacity(0.5))
                            .frame(height: 80)
                        Image(systemName: "lightspectrum.horizontal")
                            .font(.system(size: 60))
                            .opacity(0.5)
                    }
                    .offset(x: max(-90, min(position.width + dragOffset.width, 90)))
                    .animation(.bouncy.speed(2), value: position)
                    .animation(.bouncy.speed(2), value: dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { event in
                                dragOffset = event.translation
                                
                                if abs(position.width + dragOffset.width + 90) <= 20 {
                                    dragOffset.width = -90 - position.width
                                }
                                if abs(position.width + dragOffset.width) <= 20 {
                                    dragOffset.width = 0 - position.width
                                }
                                if abs(position.width + dragOffset.width - 90) <= 20 {
                                    dragOffset.width = 90 - position.width
                                }
                                
                                let tmp = max(-90.0, min(position.width + dragOffset.width, 90.0))
                                value = (tmp+90.0) / 90.0
                                print("dragoffset-> \(self.dragOffset.width)")
                            }
                            .onEnded { event in
                                position.width += dragOffset.width
                                position.width = max(-90, min(90, position.width))
                                dragOffset = CGSize.zero
                                print("position\(self.position.width)")
                                
                                
                                if position.width <= -45 {
                                    position.width = -90
                                    value = 0
                                }
                                if -45 < position.width && position.width <= 45 {
                                    position.width = 0
                                    value = 1
                                }
                                if 45 < position.width {
                                    position.width = 90
                                    value = 2
                                }
                            }
                    )
                    
                }
                
                
            
        }
        .frame(height: 30)
        .padding(.horizontal)
    }
}
 
