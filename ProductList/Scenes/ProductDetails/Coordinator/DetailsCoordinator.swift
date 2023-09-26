//
//  DetailsCoordinator.swift
//  ProductList
//
//  Created by Omar Hassanein on 24/05/2023.
//

import UIKit
import SwiftUI

class DetailsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var productViewModel: ProductViewModel!
    init(navigationController: UINavigationController, productViewModel: ProductViewModel) {
        self.navigationController = navigationController
        self.productViewModel = productViewModel
    }

    func start() {
        let viewmodel = ProductDetailsViewModel()
        viewmodel.productInfo = productViewModel
        let newView = UIHostingController(rootView: ProductDetailsView(viewModel: viewmodel))
        navigationController.pushViewController(newView, animated: true)
    }
}
