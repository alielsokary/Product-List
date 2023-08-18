//
//  ProductDetailsView.swift
//  ProductList
//
//  Created by Ali Elsokary on 18/08/2023.
//

import SwiftUI

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
                            CosmosRateView(rating: $rating)
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

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
    }
}
