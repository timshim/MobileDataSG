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
    var fillPercentage: Double = 0
    var indexItem: Int = 0

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.textColor = Color.barTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
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

    private let fillView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.barForegroundColor
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
        yearVolumeStackView.spacing = 15
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

    private func setupFillView() {
        addSubview(fillView)

        let hsb = Color.barForegroundColor.hsb
        let newFillColor = UIColor(hue: hsb.hue + CGFloat(indexItem) / 100, saturation: hsb.saturation, brightness: hsb.brightness, alpha: hsb.alpha)

        fillView.backgroundColor = newFillColor

        fillView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        fillView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        fillView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        fillView.widthAnchor.constraint(equalToConstant: calculatePercentWidth()).isActive = true
    }

    func configure() {
        guard let yearlyRecord = yearlyRecord else { return }

        backgroundColor = Color.barBackgroundColor

        setupFillView()
        setupYearLabel(yearlyRecord.year)
        setupVolumeLabel(yearlyRecord.totalVolume)
        setupYearVolumeStackView()
        setupSeparator()
    }

    private func calculatePercentWidth() -> CGFloat {
        let percentage = CGFloat(fillPercentage)
        let screenWidth = UIScreen.main.bounds.width

        return screenWidth * percentage / 100
    }

}
