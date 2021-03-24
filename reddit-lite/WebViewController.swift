//
//  WebView.swift
//  reddit-lite
//
//  Created by Dongshuo Wu on 3/23/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
	var webView: WKWebView?
	
	override func loadView() {
		webView = WKWebView()
		webView?.navigationDelegate = self
		view = webView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}
