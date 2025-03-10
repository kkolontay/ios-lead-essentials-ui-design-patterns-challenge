//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

protocol FeedViewControllerDelegate {
	func didRequestFeedRefresh()
}

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching, FeedLoadingView, FeedErrorView {
	var delegate: FeedViewControllerDelegate?

	private var tableModel = [FeedImageCellController]() {
		didSet { tableView.reloadData() }
	}

	@IBOutlet private(set) var errorView: ErrorView!

	public override func viewDidLoad() {
		super.viewDidLoad()
		refresh()
	}

	@IBAction private func refresh() {
		delegate?.didRequestFeedRefresh()
	}

	func display(_ viewModel: FeedLoadingViewModel) {
		viewModel.isLoading ? refreshControl?.beginRefreshing() : refreshControl?.endRefreshing()
	}

	func display(_ cellControllers: [FeedImageCellController]) {
		tableModel = cellControllers
	}

	func display(_ viewModel: FeedErrorViewModel) {
		if let errorMessage = viewModel.errorMessage {
			errorView.show(message: errorMessage)
		} else {
			errorView.hideMessage()
		}
	}

	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		tableView.sizeTableHeaderToFit()
	}

	public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableModel.count
	}

	public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return cellController(forRowAt: indexPath).view(in: tableView)
	}

	public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cancelCellControllerLoad(forRowAt: indexPath)
	}

	public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach { indexPath in
			cellController(forRowAt: indexPath).preload()
		}
	}

	public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach(cancelCellControllerLoad)
	}

	private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
		return tableModel[indexPath.row]
	}

	private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
		cellController(forRowAt: indexPath).cancelLoad()
	}
}
