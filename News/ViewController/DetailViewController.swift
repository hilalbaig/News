//
//  DetailViewController.swift
//  News
//
//  Created by Hilal Baig on 11/9/18.
//  Copyright © 2018 Hilal Baig. All rights reserved.
//

import UIKit
import Reachability
import SDWebImage

class DetailViewController: UIViewController {

    // MARK: - IBOutlets and Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var publishedDataLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    var article: Article?

    // MARK: - 🌻 Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNetworking()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Local Class Methods
    func setupNetworking() {
        let reachability = Reachability()!
        
        reachability.whenReachable = { reachability in
            print("Reachable")
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func loadData() {
        // Setting Data
        if let author = article?.author, author.count > 0  {
            self.title = author
        } else {
            self.title = "Detail"
        }
        
        self.titleLabel.text = article?.title
        self.detailLabel.text = article?.description
        self.publishedDataLabel.text = article?.publishedAt?.UTCToLongLocal()
        
        if let url = article?.urlToImage {
            self.articleImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: { [weak self] (image, error, cacheType, imgUrl)  in
                self?.loadingActivityIndicator.isHidden = true;
            })
        } else {
            self.loadingActivityIndicator.isHidden = true;
        }
        

    }

    // MARK: - IBActions
    @IBAction func gotoURLTap(_ sender: UIButton) {
        guard let url = URL(string: (article?.url)!) else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
