//
//  MapView.swift
//  Landmarks
//
//  Created by れおおおおおおおお on 2023/04/01.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    /*
     
     ● SwiftUIの状態管理
     
     そもそも「状態」とは「UIを構築するために必要なデータ」のことを指す
     
     状態には大きく分けて２種類
        ・Local State
        ・Shared State
     
     Local State・・・その画面でしか参照されない状態(データ)で画面間で共有しない
     Shared State・・・複数の画面間で共有する状態(データ)
     
     このような状態を整合性が破綻しないように管理することを「状態管理」と呼ぶ
     
     例えば、飲食店を予約するアプリで予約画面からお店を予約したのにも関わらず、
     他の画面での予約状態が更新されていない場合、状態の整合性が取れていないと言える
     
     このような事が起こりうるので「状態管理」は重要である
     
     情報システム理論の原則に、SSOT(Single source of truth)があって
     これは「すべての状態(データ)が１箇所でのみ作成、編集されるようにする」こととされている
     
     簡単に言えば、「管理するデータを1つに絞って、それを読み書きしろ」って感じ
     
     この原則に従うことによって状態の整合性が破綻せずに信頼できる唯一の情報源となる
     つまり、状態を管理する上では、状態がSSOTであるかどうかが重要となってくる
     
     */
    
    // マップの地域情報
    @State private var region = MKCoordinateRegion()
    
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868), // 経度・緯度
//        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2) // Mapの表示領域（縮尺）
//    )
    
    var body: some View {
        // `region`の前に$を付ける事によって、値更新時にSwiftUIが検知可能になり、
        // 参照しているView(ここではMapView)が更新されるようになる
        Map(coordinateRegion: $region)
            .onAppear { // Viewが表示されるタイミングで一度だけ呼ばれる
                self.setRegion(self.coordinate)
            }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        self.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinate = CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)
        MapView(coordinate: coordinate)
    }
}
