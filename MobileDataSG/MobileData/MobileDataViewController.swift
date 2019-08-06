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

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView()
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = viewModel.screenTitle

        viewModel.fetchMobileUsageData { [weak self] error in
            if let error = error {
                self?.showAlert(message: error.localizedDescription)
                return
            }
            self?.collectionView.reloadData()
        }
    }

}
