//
//  Extensions+UIView.swift
//  reddit-lite
//
//  Created by Dongshuo Wu on 3/24/21.
//

import UIKit

extension UIView {
	func anchor(in view: UIView,
				top: CGFloat? = nil,
				left: CGFloat? = nil,
				bottom: CGFloat? = nil,
				right: CGFloat? = nil,
				height: CGFloat? = nil,
				width: CGFloat? = nil) {
		translatesAutoresizingMaskIntoConstraints = false
		if let top = top {
			topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
		}
		if let left = left {
			leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left).isActive = true
		}
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom).isActive = true
		}
		if let right = right {
			trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -right).isActive = true
		}
		if let height = height {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
		if let width = width {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
	}
}
