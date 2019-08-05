//
//  MobileDataViewController.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

final class MobileDataViewController: UIViewController {

    var viewModel: MobileDataViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = viewModel.screenTitle
    }

}
