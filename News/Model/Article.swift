//
//  Articles.swift
//  News
//
//  Created by Hilal Baig on 11/10/18.
//  Copyright © 2018 Hilal Baig. All rights reserved.
//

import Foundation

struct ArticlesResponse: Decodable {
	var status: String? = ""
	var totalResults: Int = 0
	var articles: [Article]?
}

struct Article: Decodable {
    var author: String? = ""
	var title: String? = ""
	var description: String? = ""
	var url: String? = ""
	var urlToImage: String? = ""
	var publishedAt: String? = ""
	var content: String? = ""
}

