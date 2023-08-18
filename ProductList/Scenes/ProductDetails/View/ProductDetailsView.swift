//
//  ProductDetailsView.swift
//  ProductList
//
//  Created by Ali Elsokary on 18/08/2023.
//

import SwiftUI
import Kingfisher

struct ProductDetailsView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            NavigationView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        KFImage(viewModel.imageUrl)
                            .resizable()
                            .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.productName.unwrapped)
                                .font(.body)
                            Text(viewModel.productPrice.unwrapped)
                                .font(.caption)
                            HStack {
                                CosmosRateView(rating: viewModel.productRate)
                                Text(viewModel.productDate .unwrapped)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                        }
                    }
                    Text(viewModel.productDescription.unwrapped)
                    Button {
                        viewModel.save(productId: viewModel.productID.unwrapped)
                        viewModel.updateFavoriteButtonTitle()
                    } label: {
                        Text(viewModel.getFavoriteButtonTitle())
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .font(.headline)
                    }.buttonStyle(.borderedProminent).tint(Color("MainColor"))
                    
                    Text(viewModel.productLongDescription.unwrapped)
                    Button {
                        
                    } label: {
                        Text("© 2016 Check24")
                            .font(.headline)
                            .tint(.black)
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
            .navigationTitle(viewModel.productName.unwrapped)
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
    }
}
