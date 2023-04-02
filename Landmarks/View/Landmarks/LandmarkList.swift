//
//  LandmarkList.swift
//  Landmarks
//
//  Created by れおおおおおおおお on 2023/04/02.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        return modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Show only favorites")
                }
                
                // List + ForEach
                // ・動的なListを作成できる
                // ・静的ビューと動的ビューの混合も可能
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        // 遷移先
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        // Listに表示するRow
                        LandmarkRow(landmark: landmark)
                    }
                }
                .navigationTitle("Landmarks")
            }
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
    }
}
