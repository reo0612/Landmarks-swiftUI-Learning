//
//  CircleImage.swift
//  Landmarks
//
//  Created by れおおおおおおおお on 2023/04/01.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle()) // 画像を円形にする
            .overlay {
                // 画像に沿って境界線を描画する
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7) // ドロップシャドウを追加
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
