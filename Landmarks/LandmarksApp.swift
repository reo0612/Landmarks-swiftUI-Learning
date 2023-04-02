//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by れおおおおおおおお on 2023/04/01.
//

import SwiftUI

@main
struct LandmarksApp: App {
    // @StateObject
    // インスタンスが「1つだけ生成」される
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData) // アプリ内全体で共通したModelData()を参照するようにする
        }
    }
}
