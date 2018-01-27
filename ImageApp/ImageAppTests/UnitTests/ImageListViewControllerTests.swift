//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class ImageListViewControllerTests: XCTestCase {

    var viewController: ImageListViewController!
    var mockPresenter: MockImageListPresenter!

    override func setUp() {

        super.setUp()

        mockPresenter = MockImageListPresenter()
        viewController = loadImageListViewController()
        viewController.presenter = mockPresenter

        viewController.loadViewIfNeeded()

    }

    override func tearDown() {

        viewController = nil
        mockPresenter = nil

        super.tearDown()
    }

    // MARK: - viewDidLoad

    func testViewDidLoad() {

        XCTAssertEqual(mockPresenter.recordedInvocations.viewDidLoad, 1)

        guard let refreshControl = viewController.tableView.refreshControl else {

            XCTFail("No RefreshControl configured")
            return
        }
        XCTAssertEqual(refreshControl.backgroundColor, UIColor.lightGray)
        XCTAssertEqual(refreshControl.tintColor, UIColor.black)

        refreshControl.sendActions(for: .valueChanged)

        XCTAssertEqual(mockPresenter.recordedInvocations.refreshTable, 1)
    }

    // MARK: - IBAction

    func testRetry() {

        mockPresenter.reset()

        viewController.retryButton.sendActions(for: .touchUpInside)

        XCTAssertEqual(mockPresenter.recordedInvocations.viewDidLoad, 1)
    }

    // MARK: - UITableViewDataSource

    func testNumberOfSections_When3Items() {

        let item1 = ImageListViewModel.Item.Builder().build()
        let item2 = ImageListViewModel.Item.Builder().build()
        let item3 = ImageListViewModel.Item.Builder().build()
        let viewModel = ImageListViewModel.Builder()
            .withItems([item1, item2, item3])
            .build()

        viewController.update(with: viewModel)

        let numberOfSections = viewController.numberOfSections(in: viewController.tableView)

        XCTAssertEqual(numberOfSections, 1)
    }

    func testNumberOfSections_When1Item() {

        let item1 = ImageListViewModel.Item.Builder().build()
        let viewModel = ImageListViewModel.Builder()
            .withItems([item1])
            .build()

        viewController.update(with: viewModel)

        let numberOfSections = viewController.numberOfSections(in: viewController.tableView)

        XCTAssertEqual(numberOfSections, 1)
    }

    func testNumberOfRowsInSection_When1Item() {

        let item1 = ImageListViewModel.Item.Builder().build()
        let viewModel = ImageListViewModel.Builder()
            .withItems([item1])
            .build()

        viewController.update(with: viewModel)

        let numberOfRows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(numberOfRows, viewModel.items.count)
    }

    func testNumberOfRowsInSection_When3Items() {

        let item1 = ImageListViewModel.Item.Builder().build()
        let item2 = ImageListViewModel.Item.Builder().build()
        let item3 = ImageListViewModel.Item.Builder().build()
        let viewModel = ImageListViewModel.Builder()
            .withItems([item1, item2, item3])
            .build()

        viewController.update(with: viewModel)

        let numberOfRows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(numberOfRows, viewModel.items.count)
    }

    func testCellForRowAt() {

        viewController.tableView.register(
            MockImageTableViewCell.self,
            forCellReuseIdentifier: DefaultImageTableViewCell.reuseIdentifier
        )

        let item1 = ImageListViewModel.Item.Builder()
            .withPublishedAt("asdfasfd")
            .build()
        let item2 = ImageListViewModel.Item.Builder()
            .withPublishedAt("08918012")
            .build()
        let viewModel = ImageListViewModel.Builder()
            .withItems([item1, item2])
            .build()

        viewController.update(with: viewModel)

        guard let cell1 = viewController.tableView(
            viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MockImageTableViewCell else {

            XCTFail("No MockImageTableViewCell found at indexPath (0,0)")
            return
        }
        XCTAssertEqual(cell1.recordedInvocations.update, [item1])

        guard let cell2 = viewController.tableView(
            viewController.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? MockImageTableViewCell else {

            XCTFail("No MockImageTableViewCell found at indexPath (0,0)")
            return
        }
        XCTAssertEqual(cell2.recordedInvocations.update, [item2])
    }

    // MARK: - ImageListView

    func testLoading() {

        let title = "asdf55"
        let message = "43134"

        viewController.loading(with: title, and: message)

        XCTAssertEqual(viewController.loadingView.isHidden, false)
        XCTAssertEqual(viewController.title, title)
        XCTAssertEqual(viewController.loadingMessageLabel.text, message)
    }

    func testUpdate() {

        let mockRefreshControl = MockUIRefreshControl()
        let mockTableView = MockUITableView()
        mockTableView.refreshControl = mockRefreshControl
        viewController.tableView = mockTableView

        let title = "a;lsdjf;i"
        let viewModel = ImageListViewModel.Builder()
            .withTitle(title)
            .build()

        viewController.update(with: viewModel)

        XCTAssertEqual(viewController.tableView.isHidden, false)
        XCTAssertEqual(viewController.loadingView.isHidden, true)
        XCTAssertEqual(viewController.errorView.isHidden, true)
        XCTAssertEqual(viewController.title, title)
        XCTAssertEqual(mockTableView.recordedInvocations.reloadData, 1)
        XCTAssertEqual(mockRefreshControl.recordedInvocations.endRefresing, 1)
    }

    func testUpdateFailed() {

        let mockRefreshControl = MockUIRefreshControl()
        viewController.tableView.refreshControl = mockRefreshControl

        let title = "asdf55"
        let message = "43134"

        viewController.updateFailed(with: title, and: message)

        XCTAssertEqual(viewController.loadingView.isHidden, true)
        XCTAssertEqual(viewController.errorView.isHidden, false)
        XCTAssertEqual(viewController.tableView.isHidden, true)
        XCTAssertEqual(viewController.title, title)
        XCTAssertEqual(viewController.errorMessageLabel.text, message)
        XCTAssertEqual(mockRefreshControl.recordedInvocations.endRefresing, 1)
    }

    // MARK: - UIStoryboard

    func testStoryboard() {

        XCTAssert(viewController.tableView.dataSource === viewController)
        XCTAssert(viewController.tableView.delegate === viewController)

        // Constrains could also be tested but I left them out of scope for this project
    }

    // MARK: - UITableViewDelegate

    func testTableViewWillDisplayForRowAt() {

        let viewModel = makeDefaultViewModel()

        viewController.update(with: viewModel)

        let expectation = XCTestExpectation(description: "Set Image")

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath) as! DefaultImageTableViewCell
        let mockUIImageView = MockUIImageView()
        mockUIImageView.executeOnCall.image = {

            expectation.fulfill()
        }

        cell._imageView = mockUIImageView
        viewController.tableView(viewController.tableView, willDisplay: cell, forRowAt: indexPath)

        XCTAssertNil(cell._imageView.image)

        XCTAssertEqual(mockPresenter.recordedInvocations.willDisplayImage.count, 1)
        XCTAssertEqual(mockPresenter.recordedInvocations.willDisplayImage.first?.url, viewModel.items.first!.imageUrl)

        let image = #imageLiteral(resourceName: "options-icon")
        mockPresenter.recordedInvocations.willDisplayImage.first!.completion(image)

        wait(for: [expectation], timeout: 1)

        XCTAssert(mockUIImageView.image === image)
    }

    func testtableViewDidEndDisplayingForRowAt() {

        let viewModel = makeDefaultViewModel()

        viewController.update(with: viewModel)

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath) as! DefaultImageTableViewCell

        viewController.tableView(viewController.tableView, didEndDisplaying: cell, forRowAt: indexPath)

        XCTAssertEqual(mockPresenter.recordedInvocations.endDisplayingImage.count, 1)
        XCTAssertEqual(mockPresenter.recordedInvocations.endDisplayingImage.first, viewModel.items.first!.imageUrl)
    }

}

extension ImageListViewControllerTests {

    private func loadImageListViewController() -> ImageListViewController {

        let navigationController = UIStoryboard(
            name: "Main",
            bundle: .main
        ).instantiateInitialViewController() as! UINavigationController

        return navigationController.topViewController as! ImageListViewController
    }

    private func makeDefaultViewModel() -> ImageListViewModel {

        let item1 = ImageListViewModel.Item.Builder()
            .withPublishedAt("asdfasfd")
            .build()
        let item2 = ImageListViewModel.Item.Builder()
            .withPublishedAt("08918012")
            .build()
        return ImageListViewModel.Builder()
            .withItems([item1, item2])
            .build()
    }
}

private class MockUITableView: UITableView {

    struct Invocations {

        var reloadData = 0
    }
    var recordedInvocations = Invocations()

    override func reloadData() {

        recordedInvocations.reloadData += 1
    }
}

private class MockUIRefreshControl: UIRefreshControl {

    struct Invocations {

        var endRefresing = 0
    }
    var recordedInvocations = Invocations()

    override func endRefreshing() {

        recordedInvocations.endRefresing += 1
    }
}

private class MockUIImageView: UIImageView {

    struct ExecuteOnCall {

        var image: (() -> Void)? = nil
    }
    var executeOnCall = ExecuteOnCall()

    override var image: UIImage? {
        get {
            return super.image
        }
        set {
            super.image = newValue
			if newValue != nil {

				executeOnCall.image?()
			}
        }
    }
}
