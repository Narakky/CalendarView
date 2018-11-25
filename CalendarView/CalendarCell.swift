//
//  CalendarCell.swift
//  CalendarView
//
//  Created by Narakky on 2018/11/25.
//  Copyright © 2018 棤木亮翔. All rights reserved.
//

import UIKit

final class CalendarCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        dayLabel.text = ""
        imageView.isHidden = true
    }

    // MARK: - Internal

    func configure(indexPath: IndexPath) {
        // テキストカラー
        if indexPath.row % 7 == 0 {
            dayLabel.textColor = UIColor.sundayTextColor
        } else if indexPath.row % 7 == 6 {
            dayLabel.textColor = UIColor.saturdayTextColor
        } else {
            dayLabel.textColor = UIColor.weekdayTextColor
        }

        if indexPath.section == 0 {
            // 曜日表示
            dayLabel.text = DateManager.weekArray[indexPath.row]
            // 画像非表示
            imageView.isHidden = true
        } else {
            // 日にち表示
            dayLabel.text = DateManager.shared.conversionDateFormat(indexPath: indexPath)
            // 画像表示
            imageView.isHidden = false
        }
    }
}
