//
//  Service.swift
//  reddit-lite
//
//  Created by Dongshuo Wu on 3/23/21.
//

import Foundation

class Service {
	private let session: URLSession
	private let decoder: JSONDecoder
	private let url: String = "https://www.reddit.com"
	private let jsonSuffix: String = "/.json"
	
	init(session: URLSession = .shared,
		 decoder: JSONDecoder = JSONDecoder()) {
		self.session = session
		self.decoder = decoder
	}
	
	func loadPosts(_ completion: @escaping ([Post], Error?) -> ()) {
		guard let url = URL(string: url + jsonSuffix) else {
			fatalError("I'm drunk!")
		}
		let request = URLRequest(url: url)
		session.dataTask(with: request) { data, response, error in
			if let error = error {
				completion([], error)
				return
			}
			do {
				let data = data ?? Data()
				let listing = try self.decoder.decode(Listing.self, from: data)
				completion(listing.posts, nil)
			} catch {
				completion([], error)
			}
		}.resume()
	}
}
