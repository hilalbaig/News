//
//  DetailViewController.swift
//  News
//
//  Created by Hilal Baig on 11/9/18.
//  Copyright © 2018 Hilal Baig. All rights reserved.
//

import UIKit
import Reachability

class DetailViewController: UIViewController {

    // MARK: - IBOutlets and Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var publishedDataLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!

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
    }

    // MARK: - IBActions
    @IBAction func gotoURLTap(_ sender: UIButton) {
    }
}
