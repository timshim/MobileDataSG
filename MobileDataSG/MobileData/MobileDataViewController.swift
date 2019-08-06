//
//  MobileDataViewController.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

final class MobileDataViewController: UIViewController, Alertable {

    var viewModel: MobileDataViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = viewModel.screenTitle

        viewModel.fetchMobileUsageData { [weak self] error in
            if let error = error, let message = error.message {
                self?.showAlert(message: message)
                return
            }
        }
    }

}
