//
//  ProductDetailsView+ViewModel.swift
//  ProductList
//
//  Created by Ali Elsokary on 18/08/2023.
//

import Foundation

extension ProductDetailsView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var productID: String?
        @Published private(set) var productName: String?
        @Published private(set) var productDescription: String?
        @Published private(set) var productLongDescription: String?
        @Published private(set) var productPrice: String?
        @Published private(set) var productDate: String?
        @Published private(set) var imageUrl: URL?
        @Published private(set) var favoriteButtonTitle: String?
        @Published var productRate: Double  = 0.0

        var productInfo: ProductViewModel? {
            didSet {
                processProductData(data: productInfo)
            }
        }
        
        func isFavorited() -> Bool {
            let favoritesManager = FavoritesManager<FavoriteID>(key: "FavoriteIDs")
            let retrievedFavoriteIDs = favoritesManager.retrieveFavorites()
            for i in retrievedFavoriteIDs {
                if i.id == productID {
                    return true
                }
            }
            return false
        }
        
        func getFavoriteButtonTitle() -> String {
            isFavorited() ? "UnFavorite" : "Favorite"
        }
                
        func updateFavoriteButtonTitle() {
            favoriteButtonTitle = isFavorited() ? "UnFavorite" : "Favorite"
        }
        
        func save(productId: String) {
            let favoritesManager = FavoritesManager<FavoriteID>(key: "FavoriteIDs")
            let favoriteID = FavoriteID(id: productId)
            var retrievedFavoriteIDs = favoritesManager.retrieveFavorites()
            for i in retrievedFavoriteIDs {
                if i.id == productId {
                    favoritesManager.removeFavorite(favoriteID)
                    return
                }
            }
            retrievedFavoriteIDs.append(favoriteID)
            favoritesManager.saveFavorites(retrievedFavoriteIDs)
        }
        
        // MARK: - process Product data
        private func processProductData(data: ProductViewModel?) {
            productID = "\(data?.id ?? 0)"
            productName =  data?.name
            productDescription = data?.description
            productLongDescription = data?.longDescription
            productPrice = data?.price
            productDate = data?.releaseDate
            productRate = data?.rating.approximateToNearestHalf() ?? 0.0
            if let url = URL(string: data?.imageUrl ?? "") {
                imageUrl = url
            }
        }
    }
}
