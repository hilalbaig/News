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
    
        }
}

// MARK: - UIImageView Class Extension
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, _, error) -> Void in

            if error != nil {
                print(error ?? "Error in downloading image")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }}

// MARK: - Date Extension
extension String {
    func  changeServerDateFormat() -> String {

        let dateformater = DateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd"
        let date = dateformater.date(from: self)
        let newDF = DateFormatter()
        newDF.dateFormat = "MMM dd, yyyy"
        let dateString = newDF.string(from: date!)
        return dateString
    }
}
