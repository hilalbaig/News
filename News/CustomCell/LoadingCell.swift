//
//  LoadingCell.swift
//  News
//
//  Created by Hilal Baig on 11/9/18.
//  Copyright © 2018 Hilal Baig. All rights reserved.
//

import UIKit
import Shimmer

class LoadingCell: UITableViewCell {

    @IBOutlet weak var shimeringView: FBShimmeringView!
    @IBOutlet weak var itemsView: UIView!
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
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
