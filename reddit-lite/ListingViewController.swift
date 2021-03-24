//
//  ListingViewController.swift
//  reddit-lite
//
//  Created by Dongshuo Wu on 3/23/21.
//

import UIKit

public let cellIdentifier = "cellIdentifier"

class ListingViewController: UIViewController {
	
	lazy var refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self,
								 action: #selector(reloadPosts),
								 for: .valueChanged)
		return refreshControl
	}()
	
	lazy var listTableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorColor = .white
		tableView.refreshControl = refreshControl
		return tableView
	}()
	
	private let filterView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let textField: UITextField = {
		let textField = UITextField()
		textField.tintColor = .lightGray
		textField.placeholder = "Enter subreddit"
		textField.borderStyle = .line
		textField.layer.borderWidth = 1
		textField.layer.borderColor = UIColor.lightGray.cgColor
		textField.addTarget(self, action: #selector(filterPosts), for: .editingChanged)
		return textField
	}()
	
	lazy var applyButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(.black, for: .normal)
		let attributedTitle = NSAttributedString(string: "Clear",
												 attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
		button.setAttributedTitle(attributedTitle, for: .normal)
		button.addTarget(self, action: #selector(clearFilter), for: .touchUpInside)
		return button
	}()
	
	@objc func filterPosts() {
		applyButton.isEnabled = textField.text?.count ?? 0 > 0
		viewModel.filter(by: textField.text)
	}
	
	@objc func clearFilter() {
		textField.text = ""
		viewModel.filter(by: textField.text)
	}
	
	private var viewModel: ListingViewable
	
	init(viewModel: ListingViewable) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavigationBar()
		setUpViews()
		setUpObservers()
		viewModel.loadPosts()
	}
	
	private func configureNavigationBar() {
		title = "Reddit"
	}
	
	private func setUpFilterView() {
		filterView.addSubview(textField)
		textField.anchor(in: filterView, top: 5, left: 20, bottom: 5, right: 60)
		filterView.addSubview(applyButton)
		NSLayoutConstraint.activate([
			applyButton.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 5),
			applyButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 5),
			applyButton.bottomAnchor.constraint(equalTo: filterView.bottomAnchor, constant: -5),
			applyButton.trailingAnchor.constraint(equalTo: filterView.trailingAnchor, constant: -5)
		])
	}
	
	private func setUpViews() {
		view.backgroundColor = .white
		view.addSubview(filterView)
		filterView.anchor(in: view, top: 0, left: 0, right: 0, height: 44)
		setUpFilterView()
		view.addSubview(listTableView)
		listTableView.anchor(in: view, top: 44, left: 0, bottom: 0, right: 0)
		listTableView.register(PostListCell.self, forCellReuseIdentifier: cellIdentifier)
	}
	
	private func setUpObservers() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(startRefreshing),
											   name: ListNotifications.loadPostsBegins.name,
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(reloadTableView),
											   name: ListNotifications.loadPostsSuccess.name,
											   object: nil)
	}
	
	@objc func reloadPosts() {
		viewModel.loadPosts()
	}
	
	@objc func startRefreshing() {
		refreshControl.beginRefreshing()
	}
	
	@objc func reloadTableView() {
		refreshControl.endRefreshing()
		listTableView.reloadData()
	}
}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print(viewModel.listCount)
		return viewModel.listCount
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostListCell else {
			return UITableViewCell()
		}
		cell.postLabel.text = viewModel.postTitle(at: indexPath.row)
		cell.subredditNameLabel.text = viewModel.postSubredditNamePrefixed(at: indexPath.row)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let url = viewModel.postURL(at: indexPath.row) else { return }
		let postViewController = PostViewController(url: url)
		navigationController?.pushViewController(postViewController, animated: true)
	}
}
