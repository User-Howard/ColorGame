//
//  ColorGameApp.swift
//  ColorGame
//
//  Created by Howard Wu on 2024/2/11.
//

import SwiftUI
import TipKit

@main
struct ColorGameApp: App {
    init() {
        try? Tips.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
