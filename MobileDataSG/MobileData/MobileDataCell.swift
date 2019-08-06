//
//  MobileDataCell.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

final class MobileDataCell: UICollectionViewCell {

    var yearlyRecord: YearlyRecord?

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = Color.barTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Color.barTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.barSeparatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var yearVolumeStackView: UIStackView!

    private func setupYearLabel(_ year: Int) {
        addSubview(yearLabel)
        yearLabel.text = "\(year)"
    }

    private func setupVolumeLabel(_ volume: Double) {
        addSubview(volumeLabel)
        volumeLabel.text = "\(volume) PB"
    }

    private func setupYearVolumeStackView() {
        yearVolumeStackView = UIStackView(arrangedSubviews: [yearLabel, volumeLabel])
        yearVolumeStackView.axis = .horizontal
        yearVolumeStackView.spacing = 10
        yearVolumeStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(yearVolumeStackView)

        yearVolumeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        yearVolumeStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    private func setupSeparator() {
        addSubview(separatorView)

        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func configure() {
        guard let yearlyRecord = yearlyRecord else { return }

        backgroundColor = Color.barBackgroundColor

        setupYearLabel(yearlyRecord.year)
        setupVolumeLabel(yearlyRecord.totalVolume)
        setupYearVolumeStackView()
        setupSeparator()
    }

}
