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
	@IBOutlet weak var sortSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {

        configurePullDownToRefresh()

		configureTableView()

        presenter?.viewDidLoad()
    }
}

// MARK: - IBActions

extension ImageListViewController {

    @IBAction func retryButtonTapped() {

        presenter?.viewDidLoad()
    }

    @IBAction func tagsButtonTapped() {

		presenter?.editTagsRequest()
    }

	@IBAction func sortValueChanged() {

		let sortType: SortByType = sortSegmentedControl.selectedSegmentIndex == 0 ? .dateTaken : .datePublished

		presenter?.sortBy(sortType)
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

		guard viewModel?.items.indices.contains(indexPath.row) == true else {

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

    func loading(with title: String, and message: String, sortType: SortByType) {

        startLoading()

        self.title = title
        loadingMessageLabel.text = message

        switch sortType {

            case .dateTaken:

                sortSegmentedControl.selectedSegmentIndex = 0

            case .datePublished:

                sortSegmentedControl.selectedSegmentIndex = 1
        }
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

    func presentAlert(with viewModel: EditTagsViewModel, animated: Bool) {

        let alertViewController = makeAlertViewController(from: viewModel)

        present(alertViewController, animated: animated)
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
        tableView.refreshControl?.endRefreshing()
    }

    private func startLoading() {

        loadingView.isHidden = false
    }
}

// MARK: - Tags Helpers

extension ImageListViewController {

    private func makeAlertViewController(from viewModel: EditTagsViewModel) -> UIAlertController {

        let alert = UIAlertController(title: viewModel.title, message: nil, preferredStyle: .alert)
        alert.addTextField {

            field in

            field.placeholder = viewModel.textFieldPlaceHolder
        }

        let action = UIAlertAction(title: viewModel.buttonTitle, style: .default) {

            action in

            guard let textField = alert.textFields?.first,
                  let tags = textField.text else {

                return
            }

            viewModel.completion?(tags)
        }
        alert.addAction(action)

        let cancelAction = UIAlertAction(title: viewModel.cancelButtonTitle, style: .cancel)
        alert.addAction(cancelAction)

        return alert
    }
}

// MARK: - Pull Down To Refresh

extension ImageListViewController {

    private func configurePullDownToRefresh() {

        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .lightGray
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(pulledDownTriggered), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @IBAction func pulledDownTriggered() {

        presenter?.refreshTable()
    }
}

// MARK: - UITableView configuration

extension ImageListViewController {

    private func configureTableView() {

        tableView.tableFooterView = UIView()
    }
}
