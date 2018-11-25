//
//  DateManager.swift
//  CalendarView
//
//  Created by Narakky on 2018/11/25.
//  Copyright © 2018 棤木亮翔. All rights reserved.
//

import Foundation
import UIKit

final class DateManager {

    // MARK: - Variables

    var currentMonthOfDates: [Date] = []
    var selectedDate = Date()
    let daysPerWeek: Int = 7
    var numberOfItems: Int = 0

    // MARK: - Initializer

    private init() {}

    // MARK: - SingleTon

    static let shared = DateManager()

    // MARK: - Static

    static let weekArray = ["日", "月", "火", "水", "木", "金", "土"]

    // MARK: - Internal

    // 月ごとのセルの数を返すメソッド
    func daysOfCurrentMonth() -> Int {
        guard let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth()) else { return 0 }
        // 月が持つ週の数
        let numberOfWeeks = rangeOfWeeks.count
        // 週の数×列の数
        numberOfItems = numberOfWeeks * daysPerWeek
        return numberOfItems
    }

    func conversionDateFormat(indexPath: IndexPath) -> String {
        let dates = dateForCellAtIndexPath(numberOfItems: numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: dates[indexPath.row])
    }

    // MARK: - Private

    // 月の初日を取得
    private func firstDateOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }

    private func dateForCellAtIndexPath(numberOfItems: Int) -> [Date] {
        var dates: [Date] = []
        guard let ordinalityOfFirstDay = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth()) else { return dates }
        (0..<numberOfItems).forEach {
            var dateComponents = DateComponents()
            dateComponents.day = $0 - (ordinalityOfFirstDay - 1)
            if let date = Calendar.current.date(byAdding: dateComponents, to: firstDateOfMonth()) {
                dates.append(date)
            }
        }
        return dates
    }

}
