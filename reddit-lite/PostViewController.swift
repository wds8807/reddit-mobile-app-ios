//
//  PostViewController.swift
//  reddit-lite
//
//  Created by Dongshuo Wu on 3/24/21.
//

import UIKit
import WebKit

class PostViewController: UIViewController, WKNavigationDelegate {
	private var webView: WKWebView!
	
	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}
	
	private var url: URL
	
	init(url: URL) {
		self.url = url
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavigationBar()
		webView.load(URLRequest(url: url))
	}
	
	private func configureNavigationBar() {
		title = "Post"
		navigationController?.navigationBar.tintColor = .black
	}
	
	private func setUpViews() {
		guard let _ = webView else { return }
		view.addSubview(webView)
		NSLayoutConstraint.activate([
			webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}
