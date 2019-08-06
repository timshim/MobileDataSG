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

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()

    private let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        fetchData()
        setupCollectionView()
    }

    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = viewModel.screenTitle
    }

    private func fetchData() {
        viewModel.fetchMobileUsageData { [weak self] error in
            if let error = error, let message = error.message {
                self?.showAlert(message: message)
                return
            }
            self?.collectionView.reloadData()
        }
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(MobileDataCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

}

extension MobileDataViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.yearlyRecords.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MobileDataCell else { return UICollectionViewCell() }
        let yearlyRecord = viewModel.yearlyRecords[indexPath.item]
        cell.yearlyRecord = yearlyRecord
        cell.configure()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 80)
    }

}
