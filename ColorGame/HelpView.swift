//
//  HelpView.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/17.
//

import SwiftUI

struct HelpView: View {
    var content: String = "Hello World"
    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .stroke(style: .init(lineWidth: 4, dash: [12]))
            .overlay {
                VStack {
                    HStack {
                        Text(content)
                            .bold()
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
            }
            .opacity(0.4)
            .frame(height: 120)
            .padding([.top, .horizontal])
    }
}

#Preview {
    HelpView()
}
