//
//  Extension.swift
//  Clima
//
//  Created by Nicholas Wakaba on 07/09/2022.
//

import Foundation
import UIKit

extension String {
    /// Check whether the string is blank
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespaces).isEmpty
    }

    /// This is to localize the text
    func localize(_ lang: String? = nil) -> String {
        if lang != nil, lang?.isEmpty == false, lang?.isBlank == false {
            let path = Bundle.main.path(forResource: lang, ofType: "lproj")
            let bundle = Bundle(path: path!)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        } else {
            return NSLocalizedString(self, comment: "")
        }
    }
}

extension UITableViewCell {
    // The cell idetifier
    static var identifier: String {
        return String(describing: self)
    }

    /** adds a drop shadow to the background view of the (grouped) cell */
    func addShadowToCellInTableView(tableView: UITableView, indexPath: IndexPath) {
        // the shadow rect determines the area in which the shadow gets drawn
        guard var shadowRect: CGRect = backgroundView?.bounds else { return }
        shadowRect.size.height += 5
        shadowRect.origin.x += 50
        shadowRect.size.width -= 50

        // now configure the background view layer with the shadow
        let layer: CALayer = backgroundView!.layer
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.75
        layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
        layer.masksToBounds = false
    }
}

extension UITableViewHeaderFooterView {
    // The cell idetifier
    static var identifier: String {
        return String(describing: self)
    }
}

extension Date {
    /// Format date
    static func formatDate(from date: Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        let dayOfTheWeekString = dateFormatterGet.string(from: date)
        return dayOfTheWeekString
    }

    /// Get day of the week e.g Tuesday , Monday
    static func getDayofTheWeek(from date: Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "EEEE"
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        let dayOfTheWeekString = dateFormatterGet.string(from: date)
        return dayOfTheWeekString
    }

    /// Convert a string date to Date object
    static func stringToDate(dateString: String) -> Date {
        let dateFormatterGet = ISO8601DateFormatter()
        dateFormatterGet.formatOptions = [.withFullDate]
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        let newDate = dateFormatterGet.date(from: dateString)
        return newDate ?? Date()
    }
}

extension UIColor {
    static var sunnyColor: UIColor {
        return UIColor(hexString: "47AB2F")
    }

    static var cloudyColor: UIColor {
        return UIColor(hexString: "54717A")
    }

    static var rainyColor: UIColor {
        return UIColor(hexString: "57575D")
    }

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
