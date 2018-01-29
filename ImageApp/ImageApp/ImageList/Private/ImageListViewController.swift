//
//  Copyright © 2018 ERT Limited. All rights reserved.
//

import UIKit
import Toast_Swift

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

    func presentActions(with viewModel: ActionsViewModel, animated: Bool) {

        let alertViewController = makeAlertViewController(withActionsViewModel: viewModel)

        present(alertViewController, animated: animated)
    }

	func presentToast(with message: String, and color: UIColor) {

        var style = ToastStyle()
        style.backgroundColor = color
        self.view.makeToast(message, duration: 1.5, position: .center, style: style)
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

// MARK: - AlertViewController Helpers

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

        let cancelAction = makeCancelAlertAction(with: viewModel.cancelButtonTitle)
        alert.addAction(cancelAction)

        return alert
    }

    private func makeAlertViewController(withActionsViewModel viewModel: ActionsViewModel) -> UIAlertController {

        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)

        viewModel.actions.forEach {

            action in

            switch action {

                case let .saveToLibrary(buttonTitle, item, actionOnCompletion):

                    let alertAction = makeDefaultSaveToLibraryAlertAction(with: buttonTitle, item: item, and: actionOnCompletion)
                    alert.addAction(alertAction)

				case let .openImageInBrowser(buttonTitle, item, action):

                    let alertAction = makeDefaultOpenInSafariAlertAction(with: buttonTitle, item: item, and: action)
					alert.addAction(alertAction)

                case let .cancel(buttonTitle):

                    let cancelAction = makeCancelAlertAction(with: buttonTitle)
                    alert.addAction(cancelAction)
            }
        }

        return alert
    }

    private func makeDefaultSaveToLibraryAlertAction(
        with title: String,
        item: ImageListViewModel.Item,
		and actionCompletion: @escaping ((UIImage) -> Void)) -> UIAlertAction {

        let action = UIAlertAction(title: title, style: .default) {

            [weak self] action in

			guard let strongSelf = self else {

				return
			}

            guard let index = strongSelf.viewModel?.items.index(of: item),
				let cell = strongSelf.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? DefaultImageTableViewCell,
                  let imageToSave = cell._imageView.image else {

                return
            }

            actionCompletion(imageToSave)
        }

		return action
    }

    private func makeDefaultOpenInSafariAlertAction(
        with title: String,
        item: ImageListViewModel.Item,
        and actionCompletion: @escaping (URL) -> Void) -> UIAlertAction {

        let action = UIAlertAction(title: title, style: .default) {

            action in

            actionCompletion(item.imageUrl)
        }

        return action
    }


    private func makeCancelAlertAction(with title: String) -> UIAlertAction {

        let cancelAlert = UIAlertAction(title: title, style: .cancel)
        return cancelAlert
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
