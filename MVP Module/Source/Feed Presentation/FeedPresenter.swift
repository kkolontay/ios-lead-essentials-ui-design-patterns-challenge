//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

protocol FeedErrorView {
	func display(_ viewModel: FeedErrorViewModel)
}

typealias FeedViewFlow = FeedView & FeedErrorView

final class FeedPresenter {
	private let feedView: FeedViewFlow
	private let loadingView: FeedLoadingView

	init(feedView: FeedViewFlow, loadingView: FeedLoadingView) {
		self.feedView = feedView
		self.loadingView = loadingView
	}

	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}

	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}

	func didFinishLoadingFeed(with error: Error) {
		feedView.display(FeedErrorViewModel(errorMessage: Localized.Feed.loadError))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
