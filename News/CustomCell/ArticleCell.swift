//
//  ArticleCell.swift
//  News
//
//  Created by Hilal Baig on 11/9/18.
//  Copyright © 2018 Hilal Baig. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

	@IBOutlet weak var titleHeaderLabel: UILabel! {
		didSet {
			titleHeaderLabel.textColor = UIColor.black
        }
	}
	@IBOutlet weak var byLineLabel: UILabel! {
		didSet {
			byLineLabel.textColor = UIColor.lightGray
        }
	}

	@IBOutlet weak var dateAndTimeLabel: UILabel! {
		didSet {
			dateAndTimeLabel.textColor = UIColor.darkGray

		}
	}
	@IBOutlet weak var articleImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
