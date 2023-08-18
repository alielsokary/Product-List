//
//  MainCoordinator.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import UIKit
import SwiftUI

class MainCoordinator: NSObject, Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    @MainActor func start() {
        navigationController.delegate = self
        let service: ProductService = ProductServiceImpl()
        let viewmodel = ProductListView.VM(apiService: service)
//		let viewModel: ProductListViewModelLogic = ProductListViewModel(apiService: service)
		let storyboard = Storyboard.Main.instance
//		let viewController = storyboard.instantiateViewController(identifier: ProductListViewController.storyboardID) { coder in
//			return ProductListViewController(coder: coder, coordinator: self, viewModel: viewModel)
//		}

        let newView = UIHostingController(rootView: ProductListView(viewModel: viewmodel))
        newView.rootView.coordinator = self
        navigationController.pushViewController(newView, animated: true)
//		navigationController.pushViewController(viewController, animated: false)
    }

    @MainActor func navigateToNewScreen(with data: ProductViewModel) {
        let newcordinator = DetailsCoordinator(navigationController: navigationController, productViewModel: data)

        childCoordinators.append(newcordinator)
        newcordinator.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
}
