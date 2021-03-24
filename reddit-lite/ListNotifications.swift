//
//  ListNotifications.swift
//  reddit-lite
//
//  Created by Dongshuo Wu on 3/24/21.
//

import Foundation

public enum ListNotifications: String {
	case loadPostsBegins
	case loadPostsSuccess
	
	public var name: Notification.Name {
		Notification.Name(rawValue: rawValue)
	}
}

public extension ListNotifications {
	func post(with object: Any? = nil,
			  userInfo: [AnyHashable: Any]? = nil,
			  notificationCenter: NotificationCenter = NotificationCenter.default) {
		let notification = Notification(name: name,
										object: object,
										userInfo: userInfo)
		DispatchQueue.dispatchToMainAsync {
			notificationCenter.post(notification)
		}
	}
}

public extension DispatchQueue {
	static func dispatchToMainAsync(work: @escaping () -> Void) {
		if Thread.isMainThread {
			return work()
		}
		DispatchQueue.main.async {
			work()
		}
	}
}
