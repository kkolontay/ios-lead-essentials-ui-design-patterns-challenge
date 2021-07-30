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
	func displayError(_ error: Error)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView

	init(feedView: FeedView, loadingView: FeedLoadingView) {
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
		feedView.displayError(error)
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
