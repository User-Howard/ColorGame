//
//  ContentView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/11.
//

import SwiftUI
import AVFoundation
import Combine

struct ColorItem {
    var id = UUID().uuidString
    var red: Double = 0.0
    var green: Double = 0.0
    var blue: Double = 0.0
    
    func adding(_ other: ColorItem) -> ColorItem {
        
        let r = max(self.red, other.red)
        let g = max(self.green, other.green)
        let b = max(self.blue, other.blue)
        print("(\(r), \(g), \(b))")
        return ColorItem(red: r,
                         green: g,
                         blue: b)
    }
    
    func normalized() -> ColorItem {
        var normalizedRed = red
        var normalizedGreen = green
        var normalizedBlue = blue
        
        if normalizedRed > 1.0 {
            normalizedRed = 1.0
        }
        if normalizedGreen > 1.0 {
            normalizedGreen = 1.0
        }
        if normalizedBlue > 1.0 {
            normalizedBlue = 1.0
        }
        
        return ColorItem(red: normalizedRed, green: normalizedGreen, blue: normalizedBlue)
    }
}

struct ColorCircle: View {
    var color: ColorItem
    
    @State private var dragOffset = CGSizeZero
    @State private var isAdding: Bool = false
    @Binding var ColorItems: [ColorItem]
    @Binding var BlendedColor: ColorItem

    
    var body: some View {
        Button(action: {
            ColorItems.append(color)
            print("\(ColorItems.count)")
            UpdateBlendedColor()
        }, label: {
            Circle()
                .fill(Color(red: 1 - color.red, green: 1 - color.green, blue: 1 - color.blue))
            
                .stroke(.gray, style: .init(lineWidth: 3, dash: [12]))
                .frame(width: 60, height: 60)
                .offset(x: dragOffset.width, y: dragOffset.height)
                .animation(.easeIn, value: dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged {event in
                            self.dragOffset = event.translation
                            print("\(self.dragOffset.height)")
                            isAdding = event.translation.height < -250
                        }
                        .onEnded { event in
                            if( event.translation.height < -250) {
                                ColorItems.append(color)
                                print("\(ColorItems.count)")
                                UpdateBlendedColor()
                            }
                            isAdding = false
                            self.dragOffset = CGSizeZero
                            print("\(self.dragOffset)")
                        }
                )
                
        })
        
    }
    func combineColors(_ colorItems: [ColorItem]) -> ColorItem {
        guard let firstColor = colorItems.first else {
            return ColorItem() // 如果数组为空，返回默认的 ColorItem
        }
        
        // 从第二个 ColorItem 开始，依次将其颜色值与第一个 ColorItem 相加
        let combinedColor = colorItems.dropFirst().reduce(firstColor) { (result, colorItem) in
            return result.adding(colorItem)
        }
        
        // 将合成颜色归一化处理
        let normalizedColor = ColorItem(red: min(1.0, combinedColor.red),
                                         green: min(1.0, combinedColor.green),
                                         blue: min(1.0, combinedColor.blue))
        
        return normalizedColor
    }
    func UpdateBlendedColor() -> Void {
        // 计算混合后的颜色
        let blendedColor = combineColors(ColorItems)
        print("\(blendedColor.red), \(blendedColor.green), \(blendedColor.blue)")
        // 更新绑定的混合颜色
        BlendedColor = blendedColor
    }
}
struct PigmentView: View {
    @State var BlendedColor: ColorItem = ColorItem()
    @State var ColorItems: [ColorItem] = []
    @State var ColorTable: [ColorItem] = [ColorItem(red: 1), ColorItem(green: 1),ColorItem(blue: 1)]
    
    
    @State private var gameTime: Double = 30.00
    @State private var number: Double = 0.00 // 游戏时间
    @State private var isGameEnd = false
    @State private var isVictory = false
    @State private var startGame = false
    @State private var goalColor: ColorItem = ColorItem() // 目标颜色
    @State private var player = AVPlayer()
    
    @Binding var selectDifficulty: Bool
    @State private var difficulty: Double = 1.0;
    @Binding var selection: Int
    @State private var showTip: Bool = false
    var body: some View {
        VStack {
            if(startGame) {
                ZStack {
                    Text(String(format: "%.2f", number))
                        .font(.system(.largeTitle, design: .monospaced))
                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: {
                            self.isVictory = checkAnswer()
                            self.isGameEnd = true
                            self.startGame = false
                        }, label: {
                            Text("Submit")
                        })
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
                // 目标颜色
                HStack {
                    Text("Goal\nColor")
                        .font(.title)
                        .frame(width: 80)
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color(red: goalColor.red, green: goalColor.green, blue: goalColor.blue))
                        .stroke(.gray, style: .init(lineWidth: 2, dash: [12]))
                }
                .frame(height: 70)
                .padding()
            } else {
                ZStack(alignment: .center) {

                    Button(action: {
                        StartGame()
                    }, label: {
                        Text("Start Game")
                            .font(.largeTitle)
                    })
                    .buttonStyle(.borderedProminent)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.selectDifficulty = true
                        }, label: {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 30))
                                .tint(.black)
                        })
                        .padding()
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            showTip = true
                        }, label: {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.system(size: 30))
                                .tint(.black)
                        })
                        .padding()
                    }
                    .offset(y: 50)
                }
            }
            
            ZStack {
                if BlendedColor.red == 0.0 && BlendedColor.green == 0.0 && BlendedColor.blue == 0.0 {
                    Circle()
                        .fill(.blue.opacity(0.08).gradient)
                        .stroke(.blue, style: .init(lineWidth: 1, dash: [12]))
                        .frame(width: UIScreen.main.bounds.width*0.9)
                }
                else {
                    Circle()
                        .fill(Color(red:1 - BlendedColor.red, green: 1 - BlendedColor.green, blue: 1 - BlendedColor.blue))
                        .frame(width: UIScreen.main.bounds.width*0.9)
                }
                VStack {
                    Spacer()
                    BottomColorChooser()
                }
            }
            
        }
        .alert(isPresented: $isGameEnd) {
            // 根据游戏结果显示弹窗
            if isVictory {
                PlayClap()
                return Alert(title: Text("Victory!"), message: Text("Congratulations, you matched the color!"), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text("Game Over"), message: Text("Sorry, you didn't match the color in time."), dismissButton: .default(Text("OK")))
            }
        }
        .sheet(isPresented: $selectDifficulty, content: {
            ZStack {
                ChooseDifficultyView(A: $difficulty, startSelect: $selectDifficulty, color: Color("Pigment"))
                    .background(Color("Pigment"))
                    .presentationDetents([.height(500)])
                returnButtonView(ex: $selectDifficulty)
            }
        })
        .sheet(isPresented: $showTip, content: {
            ZStack {
                
                VStack(spacing: 5) {
                    showColorBlend(A: Color(red: 1, green: 1, blue: 0),
                                   B: Color(red: 1, green: 0, blue: 1),
                                   equal: .red)
                    Divider()
                    showColorBlend(A: Color(red: 1, green: 0, blue: 1),
                                   B: Color(red: 0, green: 1, blue: 1),
                                   equal: .blue)
                    Divider()
                    showColorBlend(A: Color(red: 0, green: 1, blue: 1),
                                   B: Color(red: 1, green: 1, blue: 0),
                                   equal: .green)
                }
                
                returnButtonView(ex: $showTip)
                
            }
            .presentationDetents([.height(200)])
            .background(Color("Pigment"))
        })
        /*
         
        .sheet(isPresented: $selectDifficulty, content: {
            ZStack(alignment: .top) {
                ChooseDifficultyView(A: $difficulty, startSelect: $selectDifficulty, color: Color("Pigment"))
                HelpView(color: Color("Pigment"), content: "Magenta + Cyan = Blue\nCyan + Yellow = Green\nYellow + Magenta = Red")
            }
            .background(Color("Pigment"))
        })*/
        
    }
    func showColorBlend(A: Color, B: Color, equal: Color) -> some View {
        HStack(spacing: 7) {
            whiteBorderColorBall(color: A)
            Image(systemName: "plus")
                .font(.system(size: 12, weight: .bold))
            whiteBorderColorBall(color: B)
            Image(systemName: "equal")
                .font(.system(size: 12, weight: .bold))
            whiteBorderColorBall(color: equal)
        }
        
    }
    func whiteBorderColorBall(color: Color) -> some View {
        ZStack {
            Image(systemName: "lightspectrum.horizontal")
                .font(.system(size: 44))
                .foregroundStyle(color)
            
            Circle()
                .fill(color)
                .stroke(.white, style: .init(lineWidth: 2.4))
                .frame(width: 28)
        }
    }
    func BottomColorChooser() -> some View {
        HStack {
            Spacer()
            ForEach(ColorTable, id: \.id) { col in
                ColorCircle(color: col, ColorItems: $ColorItems, BlendedColor: $BlendedColor)
                Spacer()
            }
            Button(action: {
                self.ColorItems = []
                BlendedColor = ColorItem()
            }, label: {
                Image(systemName: "delete.left.fill")
                    .font(.system(size: 35))
            })
            
            
            Spacer()
        }
    }
    func checkAnswer() -> Bool {
        return 1 - self.BlendedColor.red == self.goalColor.red && 1 - self.BlendedColor.green == self.goalColor.green && 1 - self.BlendedColor.blue == self.goalColor.blue
    }
    func StartGame() {
        
        self.gameTime = 45 - 15 * self.difficulty
        self.ColorItems = []
        self.startGame = true
        self.isGameEnd = false
        self.number = self.gameTime
        self.goalColor = GetGoalColor()
        self.isVictory = false
        
        BlendedColor = ColorItem()
        
        // 设置游戏计时器
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.number -= 0.01
            if self.number <= 0 {
                self.isVictory = checkAnswer()
                self.isGameEnd = true
                self.startGame = false
            }
            if self.isGameEnd {
                timer.invalidate()
            }
        }
        
    }
    func GetGoalColor() -> ColorItem {
        let randomred: Double = Double(Int.random(in: 0...1))
        let randomgreen: Double = Double(Int.random(in: 0...1))
        let randomblue: Double = Double(Int.random(in: 0...1))
        return ColorItem(red:randomred, green: randomgreen, blue: randomblue)
    }
    func UpdateBlendedColor(){
        print("Updated")
    }
    func PlayClap() {
        let url = Bundle.main.url(forResource: "Clap", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
}
#Preview {
    ContentView(prograss_: 2)
}
