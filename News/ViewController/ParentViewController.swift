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

    var arrArtciles: [Article] = []

    private let refreshControl = UIRefreshControl()

    var isDataLoading: Bool = false

    // MARK: - 🌻 Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Set the data source and delegate
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)

        setupNetworking()
        loadData()
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
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    @objc func reachabilityChanged(note: Notification) {
        guard let reachability = note.object as? Reachability else {
            return
        }
        switch reachability.connection {
        case .wifi:
            if self.arrArtciles.count == 0 {
                self.loadData()
            }
        case .cellular:
            if self.arrArtciles.count == 0 {
                self.loadData()
            }
        case .none:
            BPStatusBarAlert().bgColor(color: .orange).message(message: "Network not reachable").show()
        }
    }
    @objc func loadData() {
        self.arrArtciles.removeAll()
        isDataLoading = true
        self.tableView.reloadData()
        //let session = URLSession.shared
        //let dataManger = DataManager(session: session)
        let url = Const.API.BaseURL + "?country=us&apiKey=" + Const.API.Key
        DataManager.sharedInstance.getArticles(url: url) { [weak self] (data, error) in
            self?.isDataLoading = false
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
            guard error == nil else {
                self?.tableView.reloadData()
                return
            }
            guard let data = data else {return}
            do {
                let response = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                self?.isDataLoading = false
                if let articles = response.articles {
                    self?.arrArtciles = articles
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }} catch let error {
                    print("Error: \(error.localizedDescription)")
                    self?.tableView.reloadData()
            }
        }
    }

    // MARK: - 🏁 Protocols Conformance

	// MARK: - UITableView Delegates and Data Source

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDataLoading {
            return 2
        }
		return arrArtciles.count
	}

	// create a cell for each table view row
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isDataLoading {
            let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            let shimmerView: FBShimmeringView = FBShimmeringView.init(frame: cell.bounds )
            shimmerView.shimmeringOpacity = 0.3
            shimmerView.isShimmering = true
            shimmerView.contentView = cell.viewWithTag(55)
            shimmerView.shimmeringEndFadeDuration = 0.3
            cell.addSubview(shimmerView)
            return cell
        } else {
            let cell: ArticleCell = (self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ArticleCell)!
            let article: Article = arrArtciles[indexPath.row]
            cell.populateData(article: article)
            return cell

        }
	}
    // Method to run when table view cell is tapped
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if !isDataLoading {
            if let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                detailView.article = arrArtciles[indexPath.row]
                self.navigationController?.pushViewController(detailView, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isDataLoading {
            return 80
        } else {
            return UITableViewAutomaticDimension
        }
    }
}
