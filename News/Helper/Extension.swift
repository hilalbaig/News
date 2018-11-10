//
//  EmptyDataViewController.swift
//  News
//
//  Created by Hilal Baig on 11/9/18.
//  Copyright © 2018 Hilal Baig. All rights reserved.
//

import Foundation
import DZNEmptyDataSet
import Reachability
import BPStatusBarAlert

// MARK: - ParentViewController Class Extension

extension ParentViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
            let str = "No Articles found!"
            let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
            return NSAttributedString(string: str, attributes: attrs)
        }

        func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
            let str = "Please check your internet connection."
            let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
            return NSAttributedString(string: str, attributes: attrs)
        }

        func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
            return UIImage(named: "taylor-swift")
        }

        func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
            let str = "Tap to refresh Data"
            let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout)]
            return NSAttributedString(string: str, attributes: attrs)
        }

        func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
            self.loadData()
        }
}

// MARK: - Date Extension
extension String {
    func  UTCToShortLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        dateFormatter.dateFormat = "h:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString.lowercased()
    }
    func  UTCToLongLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        dateFormatter.dateFormat = "E, d MMM yyyy h:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
