//
//  ModelData.swift
//  Landmarks
//
//  Created by れおおおおおおおお on 2023/04/02.
//

import Foundation
import Combine

/*
 ・ObservableObject
 
 SwiftUIで状態を管理する機能として利用されるprotocolで参照型のみ準拠可能
 
 @Publishedをプロパティに付けることによって
 その変更を監視し、変更があった場合に参照しているViewを再描画する
 
 他のViewでObservableObjectに準拠したクラスを使用する場合は
 @ObservedObjectまたは @StateObjectを付けて、定義する
 
・ @ObservedObjectの @StateObjectの違い
 
 どちらも共通する点はObservableObjectを利用するために用いられる
 
 違いとしては以下となる
 
 @ObservedObject：Viewのライフサイクルに依存し、Viewの再描画でインスタンスは「再生成」される
 @StateObject：Viewに対してインスタンスが「1つだけ生成」される
 
 @ObservedObjectはViewのライフサイクルに依存しているので例えば以下の場合は初期化されてしまう
 
 ```
 struct ContentView: View {
     @State var counter = 0
     var body: some View {
         VStack(alignment: .leading, spacing: 50) {
             HStack {
                 Text("counter: \(counter)")
                 Button("+") {
                    // ボタンをタップする度にContentViewが再描画される
                     counter += 1
                 }
             }
             ObservedObjectCounter()
             StateObjectCounter()
         }
     }
 }
 
 final class Counter: ObservableObject {
     @Published var number = 0
 }
 
 struct StateObjectCounter: View {
    // Viewのライフサイクルに依存していないので
    // ContentViewが再描画されても影響を受けない
     @StateObject private var counter = Counter()
     var body: some View {
         HStack {
             Text("StateObjectCounter: \(counter.number)")
             Button("+") {
                 counter.number += 1
             }
         }
     }
 }

 struct ObservedObjectCounter: View {
    // Viewのライフサイクルに依存しているため、
    // ContentViewが再描画されればインスタンスが再生成される
     @ObservedObject private var counter = Counter()
     
     var body: some View {
         HStack {
             Text("OvservedObjectCounter: \(counter.number)")
             Button("+") {
                 counter.number += 1
             }
         }
     }
 }
 
 参照先: https://tokizuoh.dev/posts/td152tqrb7iflicp/
 
 @StateObjectと @ObservedObjectの使い分けとしては以下が参考になりそう
 https://zenn.dev/ueshun/articles/2b26aaad40d6a3#%40state%E3%81%A8observableobject%E3%81%AE%E4%BD%BF%E3%81%84%E5%88%86%E3%81%91
 ```
 */



final class ModelData: ObservableObject {
    // @Publishedを付ける事によって外部に公開する
    // 変更がある場合、SwiftUIが参照しているViewを再描画してくれる
    @Published var landmarks: [Landmark] = load("landmarkData")
}

/// jsonファイルをデコードする
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
