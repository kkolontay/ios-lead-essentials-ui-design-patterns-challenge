//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import FeedFeature

public final class FeedUIComposer {
	private init() {}

	public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
		let presentationAdapter = FeedLoaderPresentationAdapter(
			feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader))

		let feedController = makeFeedViewController(
			delegate: presentationAdapter,
			title: Localized.Feed.title)

		presentationAdapter.presenter = FeedPresenter(
			feedView: FeedViewAdapter(
				controller: feedController,
				imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)), feedErrorView: WeakRefVirtualProxy(feedController),
			loadingView: WeakRefVirtualProxy(feedController))

		return feedController
	}

	private static func makeFeedViewController(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
		let bundle = Bundle(for: FeedViewController.self)
		let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
		let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
		feedController.delegate = delegate
		feedController.title = title
		return feedController
	}
}
