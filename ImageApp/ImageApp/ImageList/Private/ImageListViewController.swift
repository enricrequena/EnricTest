//
//  Copyright © 2018 ERT Limited. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {

    private var viewModel: ImageListViewModel?
    var presenter: ImageListPresenter?

	@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingMessageLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!

    override func viewDidLoad() {

        presenter?.viewDidLoad()
    }
}

// MARK: - IBActions

extension ImageListViewController {

    @IBAction func retryButtonTapped() {

        presenter?.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource

extension ImageListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DefaultImageTableViewCell.reuseIdentifier) as? DefaultImageTableViewCell,
            let item = viewModel?.items[indexPath.row] else {

            return UITableViewCell()
        }

        cell.update(with: item)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ImageListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let cell = cell as? DefaultImageTableViewCell else {

            return
        }

        guard let item = viewModel?.items[indexPath.row] else {

            return
        }

		cell._imageView.image = nil

        presenter?.willDisplayImage(from: item.imageUrl) {

            image in

            DispatchQueue.main.async {

                cell._imageView.image = image
            }
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard cell is DefaultImageTableViewCell else {

            return
        }

        guard let item = viewModel?.items[indexPath.row] else {

            return
        }

        presenter?.endDisplayingImage(from: item.imageUrl)
    }
}

// MARK: - ImageListView

extension ImageListViewController: ImageListView {

    func loading(with title: String, and message: String) {

        startLoading()

        self.title = title
        loadingMessageLabel.text = message
    }

    func update(with viewModel: ImageListViewModel) {

        self.viewModel = viewModel

		title = viewModel.title

        displayDataAndReloadTable()
    }

    func updateFailed(with title: String, and errorMessage: String) {

        self.title = title

        displayErrorView(errorMessage)
    }
}

// MARK: - Helpers

extension ImageListViewController {

    private func displayDataAndReloadTable() {

        tableView.reloadData()

        errorView.isHidden = true
        tableView.isHidden = false

        stopLoading()
    }

    private func displayErrorView(_ errorMessage: String) {

        errorMessageLabel.text = errorMessage

        tableView.isHidden = true
        errorView.isHidden = false

        stopLoading()
    }

    private func stopLoading() {

        loadingView.isHidden = true
    }

    private func startLoading() {

        loadingView.isHidden = false
    }




    }
}
