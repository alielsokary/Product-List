//
//  ProductListView.swift
//  ProductList
//
//  Created by Ali Elsokary on 18/08/2023.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = VM()
    // TODO: Make private
    var coordinator: MainCoordinator?

    var body: some View {
        NavigationView {
            List(viewModel.productList) { product in
                ProductItemView(product: product)
                    .onTapGesture {
                        let selectedIndex = viewModel.productList.firstIndex(where: { $0 == product }).unwrapped
                        coordinator?.navigateToNewScreen(with: viewModel.getCurrentProduct(at: selectedIndex))
                }
                .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 10)
                            .background(.clear)
                            .foregroundColor(.white)
                            .padding(
                                EdgeInsets(
                                    top: 6,
                                    leading: 0,
                                    bottom: 6,
                                    trailing: 0
                                )
                            )
                    )
            }.refreshable {
                viewModel.getProducts()
            }
        }.onAppear {
            viewModel.getProducts()
            
        }.navigationTitle(viewModel.listTitle.unwrapped)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(viewModel.listTitle.unwrapped).font(.headline)
                        Text(viewModel.listSubTitle.unwrapped).font(.subheadline)
                    }
                }
            }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
