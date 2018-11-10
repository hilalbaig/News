//
//  ViewController.swift
//  News
//
//  Created by Hilal Baig on 11/9/18.
//  Copyright © 2018 Hilal Baig. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import Shimmer
import BPStatusBarAlert
import Reachability

class ParentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets and Variables

	@IBOutlet weak var tableView: UITableView!

	
    var isDataLoading: Bool = false

    // MARK: - 🌻 Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Set the data source and delegate
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        setupNetworking()
    }

    override func viewWillAppear(_ animated: Bool) {
       self.title = "NEWS"
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""

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

    // MARK: - 🏁 Protocols Conformance

	// MARK: - UITableView Delegates and Data Source

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDataLoading {
            return 2
        }
		return 10
	}

	// create a cell for each table view row
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isDataLoading {
            let cell: LoadingCell = (self.tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell)!
            cell.shimeringView.contentView = cell.itemsView
            cell.shimeringView.isShimmering = true
            return cell
        } else {
            let cell: ArticleCell = (self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ArticleCell)!
            return cell

        }
	}

	// Method to run when table view cell is tapped
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if !isDataLoading {
            if let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                self.navigationController?.pushViewController(detailView, animated: true)
            }
        }
}}
