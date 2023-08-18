//
//  ProductItemView.swift
//  ProductList
//
//  Created by Ali Elsokary on 18/08/2023.
//

import SwiftUI
import Kingfisher
import Cosmos

struct ProductItemView: View {
    var product: ProductViewModel
    var body: some View {
        HStack {
            KFImage(URL(string: product.imageUrl))
                .resizable()
                .frame(width: 60, height: 60)
            VStack(alignment: .leading, spacing: 6) {
                Text(product.name)
                    .font(.title3)
                Text(product.description)
                    .font(.caption2)
                
                HStack(alignment: .center, spacing: 30) {
                    Text(product.price)
                        .foregroundColor(.gray)
                        .font(.caption2)
                    CosmosRateView(rating: product.rating)
                        .frame(width: 50, height: 20)
                }
            }
        }
    }
}
