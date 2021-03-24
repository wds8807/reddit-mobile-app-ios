//
//  PostListCell.swift
//  reddit-lite
//
//  Created by Dongshuo Wu on 3/23/21.
//

import UIKit

class PostListCell: UITableViewCell {
	
	let separator: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .lightGray
		return view
	}()
	
	let postLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 16)
		label.textAlignment = .left
		label.numberOfLines = 0
		label.sizeToFit()
		return label
	}()
	
	let subredditNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = .lightGray
		label.textAlignment = .left
		label.numberOfLines = 0
		label.sizeToFit()
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpViews()
	}
	
	private func setUpViews() {
		accessoryType = .disclosureIndicator
		addSubview(postLabel)
		postLabel.anchor(in: self, top: 5, left: 20, right: 20)
		addSubview(subredditNameLabel)
		NSLayoutConstraint.activate([
			subredditNameLabel.topAnchor.constraint(equalTo: postLabel.bottomAnchor),
			subredditNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			subredditNameLabel.heightAnchor.constraint(equalToConstant: 20),
			subredditNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
		])
		addSubview(separator)
		NSLayoutConstraint.activate([
			separator.topAnchor.constraint(equalTo: subredditNameLabel.bottomAnchor),
			separator.heightAnchor.constraint(equalToConstant: 1),
			separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			separator.trailingAnchor.constraint(equalTo: trailingAnchor),
			separator.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		bringSubviewToFront(separator)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
