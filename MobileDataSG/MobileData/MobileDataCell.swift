//
//  MobileDataCell.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

protocol CellActionDelegate: class {
    func didTapInfoButton(record: YearlyRecord)
}

final class MobileDataCell: UICollectionViewCell {

    var yearlyRecord: YearlyRecord?
    var dataRecords: [DataRecord]?
    var fillPercentage: Double = 0
    var indexItem: Int = 0
    var hasAnimated = false
    weak var delegate: CellActionDelegate?

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.textColor = Color.barTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "yearLabel"
        return label
    }()

    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = Color.barTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "volumeLabel"
        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.barSeparatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "separatorView"
        return view
    }()

    private let fillView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.barForegroundColor
        view.accessibilityIdentifier = "fillView"
        return view
    }()

    private let infoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "image_button"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "infoButton"
        return btn
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

        fillView.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.height)

        let hsb = Color.barForegroundColor.hsb
        let newFillColor = UIColor(hue: hsb.hue + CGFloat(indexItem) / 100, saturation: hsb.saturation, brightness: hsb.brightness, alpha: hsb.alpha)

        fillView.backgroundColor = newFillColor

        if !hasAnimated {
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.fillView.frame = CGRect(x: 0, y: 0, width: self.calculatePercentWidth(), height: self.frame.height)
            }, completion: { _ in
                self.hasAnimated = true
            })
        } else {
            self.fillView.frame = CGRect(x: 0, y: 0, width: self.calculatePercentWidth(), height: self.frame.height)
        }
    }

    private func addInfoButton() {
        addSubview(infoButton)

        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)

        infoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
    }

    @objc private func infoButtonTapped() {
        if let record = yearlyRecord {
            delegate?.didTapInfoButton(record: record)
        }
    }

    private func calculatePercentWidth() -> CGFloat {
        let percentage = CGFloat(fillPercentage)
        let screenWidth = self.frame.width

        return screenWidth * percentage / 100
    }

    private func setupInfoButton() {
        guard let dataRecords = dataRecords else { return }
        var quarterlyRecords = [DataRecord]()

        for dataRecord in dataRecords {
            if let year = dataRecord.getYear(), let yearlyRecord = yearlyRecord, year == yearlyRecord.year {
                quarterlyRecords.append(dataRecord)
            }
        }

        guard var initialVolume = quarterlyRecords.first?.volume else { return }
        for index in 1..<quarterlyRecords.count {
            let record = quarterlyRecords[index]
            if record.volume < initialVolume {
                addInfoButton()
                return
            } else if subviews.contains(infoButton) {
                infoButton.removeFromSuperview()
            }
            initialVolume = record.volume
        }
    }

    func configure() {
        guard let yearlyRecord = yearlyRecord else { return }

        backgroundColor = Color.barBackgroundColor

        setupFillView()
        setupYearLabel(yearlyRecord.year)
        setupVolumeLabel(yearlyRecord.totalVolume)
        setupYearVolumeStackView()
        setupSeparator()
        setupInfoButton()
    }

}
