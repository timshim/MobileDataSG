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

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        cv.accessibilityIdentifier = "collectionView"
        return cv
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .gray)
        ai.hidesWhenStopped = true
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()

    private let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
        setupActivityIndicator()
        fetchData()
    }

    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = viewModel.screenTitle
    }

    private func setupActivityIndicator() {
        collectionView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func fetchData() {
        activityIndicator.startAnimating()
        viewModel.fetchMobileUsageData { [weak self] error in
            if let error = error, let message = error.message {
                self?.showAlert(message: message)
                return
            }
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(MobileDataCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        cell.fillPercentage = fillPercentage(volume: yearlyRecord.totalVolume)
        cell.indexItem = indexPath.item
        cell.dataRecords = viewModel.dataRecords
        cell.delegate = self
        cell.configure()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 80)
    }

    private func fillPercentage(volume: Double) -> Double {
        let percent = volume * 100 / viewModel.maxVolume
        return round(percent * 100) / 100
    }

}

extension MobileDataViewController: CellActionDelegate {

    func didTapInfoButton(record: YearlyRecord) {
        let dataRecords = viewModel.dataRecords
        var quarterlyRecords = [DataRecord]()
        var message = ""

        for dataRecord in dataRecords {
            if let year = dataRecord.getYear(), year == record.year {
                quarterlyRecords.append(dataRecord)
                message.append("\(dataRecord.quarter): \(dataRecord.volume) PB\r")
            }
        }

        showAlert(message: message)
    }

}
