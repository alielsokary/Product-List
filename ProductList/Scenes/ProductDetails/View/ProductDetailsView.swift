//
//  ProductDetailsView.swift
//  ProductList
//
//  Created by Ali Elsokary on 18/08/2023.
//

import SwiftUI
import Cosmos

struct ProductDetailsView: View {
    @SwiftUI.State var rating = 3.0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    Image("08")
                        .resizable()
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading) {
                        Text("Title")
                        Text("Subtitle")
                        HStack {
                            MyCosmosView(rating: $rating)
                            Text("Label")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                }
                Text("Product Description")
                Button {
                    
                } label: {
                    Text("Favorite")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .font(.headline)
                }.buttonStyle(.borderedProminent).tint(Color("MainColor"))
                
                Text("Product Long Description")
                Button {
                    
                } label: {
                    Text("© 2016 Check24")
                        .font(.headline)
                        .tint(.black)
                }
            }.padding(.leading, 16)
                .padding(.trailing, 16)
        }
    }
}

struct MyCosmosView: UIViewRepresentable {
    @Binding var rating: Double
    
    func makeUIView(context: Context) -> CosmosView {
        CosmosView()
    }
    
    func updateUIView(_ uiView: CosmosView, context: Context) {
        uiView.rating = rating
        
        // Autoresize Cosmos view according to it intrinsic size
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // Change Cosmos view settings here
        uiView.settings.starSize = 25
        uiView.settings.fillMode = .precise
        uiView.settings.updateOnTouch = false
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
    }
}
