//
//  FeedErrorViewAdapter.swift
//  MVP
//
//  Created by kkolontay on 2021-08-03.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
final class FeedErrorViewAdapter: FeedErrorView {
	private weak var controller: FeedViewController?

	init(controller: FeedViewController) {
		self.controller = controller
	}

	func display(_ viewModel: FeedErrorViewModel) {
		controller?.displayError(viewModel.errorMessage)
	}
}
