//
//  Post.swift
//  reddit-lite
//
//  Created by Dongshuo Wu on 3/23/21.
//

import Foundation

struct Post {
	var id: String
	var title: String
	var author: String
	var url: String
	var subredditNamePrefixed: String
}

extension Post: Decodable {
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
		id = try data.decode(String.self, forKey: .id)
		title = try data.decode(String.self, forKey: .title)
		author = try data.decode(String.self, forKey: .author)
		url = try data.decode(String.self, forKey: .url)
		subredditNamePrefixed = try data.decode(String.self, forKey: .subredditNamePrefixed)
	}
}

enum CodingKeys: String, CodingKey {
	case id
	case title
	case author
	case url
	case subredditNamePrefixed = "subreddit_name_prefixed"
	case data
}
