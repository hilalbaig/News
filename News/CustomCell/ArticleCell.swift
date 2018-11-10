//
//  ArticleCell.swift
//  News
//
//  Created by Hilal Baig on 11/9/18.
//  Copyright © 2018 Hilal Baig. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {

	@IBOutlet weak var lblTitle: UILabel! {
		didSet {
			lblTitle.textColor = UIColor.black
        }
	}
	@IBOutlet weak var lblAuthor: UILabel! {
		didSet {
			lblAuthor.textColor = UIColor.lightGray
        }
	}

	@IBOutlet weak var lblPublishedAt: UILabel! {
		didSet {
			lblPublishedAt.textColor = UIColor.darkGray

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
    
    func populateData(article: Article) {
        
        lblTitle.text = article.title
        lblAuthor.text = article.author
        lblPublishedAt.text = article.publishedAt?.UTCToShortLocal()
        
        if let url = article.urlToImage {
            self.articleImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
        }
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.articleImageView.image = UIImage(named: "placeholder")
    }
    
    
}
