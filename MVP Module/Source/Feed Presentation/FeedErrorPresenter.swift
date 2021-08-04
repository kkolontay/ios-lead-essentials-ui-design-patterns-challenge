//
//  FeedErrorPresenter.swift
//  MVP
//
//  Created by kkolontay on 2021-08-03.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

protocol FeedErrorView {
	func display(_ viewModel: FeedErrorViewModel)
}

final class FeedErrorPresenter {
	private let feedErrorView: FeedErrorView
	private let loadingView: FeedLoadingView

	init(feedErrorView: FeedErrorView, loadingView: FeedLoadingView) {
		self.feedErrorView = feedErrorView
		self.loadingView = loadingView
	}

	func didFinishLoadingFeed(with error: Error) {
		feedErrorView.display(FeedErrorViewModel(errorMessage: Localized.Feed.loadError))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
