//
//  ListingViewModel.swift
//  reddit-lite
//
//  Created by Dongshuo Wu on 3/23/21.
//

import Foundation

protocol ListingViewable {
	var listCount: Int { get }
	func loadPosts()
	func postTitle(at index: Int) -> String?
	func postSubredditNamePrefixed(at index: Int) -> String?
	func postURL(at index: Int) -> URL?
	func filter(by subreddit: String?)
}

class ListingViewModel: ListingViewable {
	
	private var service = Service()
	private var allPosts: [Post] = []
	private var displayingPosts: [Post] = []
	
	var listCount: Int { displayingPosts.count }
	
	func loadPosts() {
		ListNotifications.loadPostsBegins.post()
		service.loadPosts { [weak self] posts, _ in
			DispatchQueue.main.async {
				self?.allPosts = posts
				self?.displayingPosts = posts
				ListNotifications.loadPostsSuccess.post()
			}
		}
	}
	
	func postTitle(at index: Int) -> String? {
		guard index < displayingPosts.count else { return nil }
		return displayingPosts[index].title
	}
	
	func postSubredditNamePrefixed(at index: Int) -> String? {
		guard index < displayingPosts.count else { return nil }
		return displayingPosts[index].subredditNamePrefixed
	}
	
	func postURL(at index: Int) -> URL? {
		guard index < displayingPosts.count else { return nil }
		return URL(string: displayingPosts[index].url)
	}
	
	func filter(by subreddit: String?) {
		guard let string = subreddit, string.count > 0 else {
			displayingPosts = allPosts
			ListNotifications.loadPostsSuccess.post()
			return
		}
		displayingPosts = allPosts.filter {
			$0.subredditNamePrefixed.lowercased().contains(string.lowercased())
		}
		ListNotifications.loadPostsSuccess.post()
	}
}
