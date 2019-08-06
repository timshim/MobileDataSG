//
//  AppCoordinator.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let networkingService = NetworkingService()
        let govDataService = GovDataService(networkingService: networkingService)
        let mobileDataViewModel = MobileDataViewModel(govDataService: govDataService)

        let mobileDataVC = MobileDataViewController()
        mobileDataVC.viewModel = mobileDataViewModel

        navigationController.pushViewController(mobileDataVC, animated: false)
    }
}
