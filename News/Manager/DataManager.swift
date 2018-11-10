//
//  DataManager.swift
//  News
//
//  Created by Hilal Baig on 11/10/18.
//  Copyright © 2018 Hilal Baig. All rights reserved.
//

import Foundation

class DataManager {
    private let session: URLSessionProtocol
    init(session: URLSessionProtocol) {
        self.session = session
    }
    // MARK: - Public Methods
    func getArticles(url: String, callback: @escaping (_ data: Data?, _ error: Error?) -> Void ) {
        guard let link = URL(string: url) else {
            let error = NSError(domain: "URL Error", code: 1, userInfo: nil)
            callback(nil, error)
            return
        }
        let request = URLRequest(url: link)
        let task = session.dataTask(with: request) {(data, _, error) in
            callback(data, error)
        }
        task.resume()
    }
}