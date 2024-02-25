//
//  ChartView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/19.
//

import SwiftUI
import Charts

struct ChartView: View {
    var body: some View {
        ZStack {
            Color.blue
                .opacity(0.3)
            VStack {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50)
                    
                        Circle()
                            .fill(Color(red: 18/256, green: 53/256, blue: 36/256))
                            .frame(width: 40)
                }
                Chart {
                    ForEach(data, id: \.x) { series in
                        LineMark(
                            x: .value("Month", series.x),
                            y: .value("Temp", series.y)
                        )
                        
                        .foregroundStyle(.blue)
                    }
                    /*
                     ForEach(data2, id: \.x) { series in
                     LineMark(
                     x: .value("Month", series.x),
                     y: .value("Temp", series.y)
                     )
                     
                     .foregroundStyle(.green)
                     }*/
                }
                .chartXScale(domain: [400, 800])
                .frame(height: 180)
                .padding()
            }
            Text("GOOD")
        }
    }
}

#Preview {
    ChartView()
}

struct E {
    var x: Double
    var y: Double
    init(x_: Double, y_: Double) {
        x = x_
        y = y_
    }
}
