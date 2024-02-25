//
//  LightView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/13.
//

import SwiftUI
import AVFoundation


struct LightView: View {
    @State private var r: Double = 0.0
    @State private var g: Double = 0.0
    @State private var b: Double = 0.0
    
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
            // 倒计时
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
                        .padding(.horizontal)
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
                .padding(.horizontal)
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
            
            // 显示颜色选择器
            
            Circle()
                .fill(Color(red: r/256, green: g/256, blue: b/256))
                .stroke(.gray, style: .init(lineWidth: 2, dash: [12]))
                .frame(width: UIScreen.main.bounds.width)
                .padding(.vertical)
                .animation(.bouncy, value: r)
                .animation(.bouncy, value: g)
                .animation(.bouncy, value: b)
            Spacer()
            // RGB 滑块
            
            HStack {
                Spacer()
                Circle()
                    .fill(.red)
                    .frame(width: 18)
                ColorSlider(value: $r, color: .red)
            }
            HStack {
                Spacer()
                Circle()
                    .fill(.green)
                    .frame(width: 18)
                ColorSlider(value: $g, color: .green)
            }
            HStack {
                Spacer()
                Circle()
                    .fill(.blue)
                    .frame(width: 18)
                ColorSlider(value: $b, color: .blue)
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
        .sheet(isPresented: $selectDifficulty, content:{
            ZStack(alignment: .top) {
                ChooseDifficultyView(A: $difficulty, startSelect: $selectDifficulty, color: Color("Light"))
                
                returnButtonView(ex: $selectDifficulty)
                /*HelpView(/*color: Color("Light"), */content: "The larger the RGB value, the brighter it is.")*/
            }
            .background(Color("Light"))
            .presentationDetents([.height(500)])
        })
        .sheet(isPresented: $showTip, content: {
            ZStack {
                Color("light")
                returnButtonView(ex: $showTip)
                VStack {
                    Text("The larger the RGB value, the brighter it is.")
                }
                .presentationDetents([.height(100)])
            }
            .frame(width: .infinity, height: .infinity)
            .background(Color("Light"))
        })
    }

    func checkAnswer() -> Bool {
        return abs(self.r/256 - self.goalColor.red) < 0.01 && abs(self.g/256 - self.goalColor.green) < 0.01 && abs(self.b/256 - self.goalColor.blue) < 0.01
    }
    func StartGame() {
        
        self.gameTime = 45 - 15 * self.difficulty
        self.startGame = true
        self.isGameEnd = false
        self.number = self.gameTime
        self.goalColor = GetGoalColor()
        self.isVictory = false
        self.r = 0
        self.g = 0
        self.b = 0
        
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
        let randomred: Double = Double(Int.random(in: 1...4)) * 64 / 256
        let randomgreen: Double = Double(Int.random(in: 1...4)) * 64 / 256
        let randomblue: Double = Double(Int.random(in: 1...4)) * 64 / 256
        return ColorItem(red:randomred, green: randomgreen, blue: randomblue)
    }
    func PlayClap() {
        let url = Bundle.main.url(forResource: "Clap", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
}

// 自定义颜色滑块
struct ColorSlider: View {
    @Binding var value: Double
    var color: Color
    @State var to_: Double = 256
    @State var step_: Double = 64
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .bottomLeading) {
                    /*
                    Rectangle()
                        .foregroundColor(Color.gray)
                        .frame(width: geometry.size.width, height: 2)
                    */
                    
                    ForEach(0..<(Int(to_ / step_) + 1), id: \.self) { index in // 调整刻度数量
                        let xPos = CGFloat(index) * ((geometry.size.width-28) / (to_ / step_)) // 刻度位置
                        
                        Circle()
                            .fill(Color.gray)
                            .frame(height: 10) // 调整刻度的高度
                            .offset(x: xPos+9, y: -10)
                        
                    }
                    
                    Slider(value: $value, in: 0...to_, step: step_)
                        .accentColor(color)
                }
            }
        }
        .frame(height: 30)
        .padding(.horizontal)
    }
    
}

struct returnButtonView: View {
    @Binding var ex: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    ex = false
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                })
                .tint(.black.opacity(0.6))
                .padding()

            }
            Spacer()

        }
    }
    
}
#Preview {
    ContentView(prograss_: 3)
}
