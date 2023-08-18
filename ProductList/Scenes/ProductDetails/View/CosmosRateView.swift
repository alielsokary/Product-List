//
//  CosmosRateView.swift
//  ProductList
//
//  Created by Ali Elsokary on 18/08/2023.
//

import SwiftUI
import Cosmos

struct CosmosRateView: UIViewRepresentable {
    @Binding var rating: Double
    
    func makeUIView(context: Context) -> CosmosView {
        CosmosView()
    }
    
    func updateUIView(_ uiView: CosmosView, context: Context) {
        uiView.rating = rating
        
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        uiView.settings.starSize = 25
        uiView.settings.fillMode = .precise
        uiView.settings.updateOnTouch = false
    }
}
