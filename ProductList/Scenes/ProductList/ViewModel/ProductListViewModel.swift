//
//  ProductListViewModel.swift
//  ProductList
//
//  Created by Ali Elsokary on 18/08/2023.
//

import Foundation
import Combine

class ProductListViewModel: ObservableObject {

    private let apiService: ProductService

    init(apiService: ProductService) {
        self.apiService = apiService
    }

    @Published var listTitle: String?
    @Published var listSubTitle: String?
    @Published var selectedSegmentIndex: Int = 0

    private var cancelable: Set<AnyCancellable> = []

    // MARK: - API result
    var products: Products? {
        didSet {
            self.listTitle = products?.header.headerTitle
            self.listSubTitle = products?.header.headerDescription
            self.processProductData(data: products?.products)
        }
    }

    // MARK: - fetched result from ProductViewModel
    // TODO make private
    var productList: [ProductViewModel] = [ProductViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var numberOfProducts: Int {
        return productList.count
    }

    // MARK: - callback for interfaces

    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    // MARK: closures for binding
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var reloadTableViewClosure: (() -> Void)?

    // MARK: - prepare products data
    private func processProductData(data: [Product]?) {
        self.productList = data?.compactMap { ProductViewModel(data: $0) } ?? []
    }

    // MARK: - process fetched result
    func getCurrentProduct(at index: Int) -> ProductViewModel {
        return productList[index]
    }

    // MARK: - Filter

    func filterProducts(at filterID: Int) {
        switch filterID {
        case 2:
            self.productList = products?.products.compactMap { ProductViewModel(data: $0) } ?? []
            self.productList = self.productList.filter({$0.isAvailable == true})
        case 3:
            print("Fav filter")
            // Fav filter
        default:
            self.productList = products?.products.compactMap { ProductViewModel(data: $0) } ?? []
        }
    }

    func getProducts() {
        apiService.dispatch(
            APIRouter.GetProducts(
                queryParams: APIParameters.ProductParams(skip: 1, limit: 10)))
        .sink { [weak self] completion in
            switch completion {
            case .finished: break
            case let .failure(error):
                self?.alertMessage = error.errorDescription
            }
        }
    receiveValue: { [weak self] products in
        self?.products = products
    }.store(in: &cancelable)
    }
}
