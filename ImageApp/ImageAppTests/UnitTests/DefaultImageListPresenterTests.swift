//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

import XCTest
@testable import ImageApp

class DefaultImageListPresenterTests: XCTestCase {

    var presenter: DefaultImageListPresenter!
    var mockInteractor: MockImageListInteractor!
    var mockAdapter: MockDataFeedToImageListViewModelAdapter!
    var mockView: MockImageListView!
    var mockWireframe: MockImageListWireframe!

    override func setUp() {

        super.setUp()

        mockInteractor = MockImageListInteractor()
        mockAdapter = MockDataFeedToImageListViewModelAdapter()
        mockView = MockImageListView()
        mockWireframe = MockImageListWireframe()

        presenter = DefaultImageListPresenter(
            interactor: mockInteractor,
            adapter: mockAdapter,
            view: mockView,
            wireframe: mockWireframe
        )
    }

    override func tearDown() {

        presenter = nil
        mockInteractor = nil
        mockAdapter = nil
        mockView = nil
        mockWireframe = nil

        super.tearDown()
    }

    // MARK: - Init

    func testInit() {

        XCTAssert(presenter.interactor === mockInteractor)
        XCTAssert(presenter.adapter === mockAdapter)
        XCTAssert(presenter.view === mockView)
        XCTAssert(presenter.wireframe === mockWireframe)
    }

    // MARK: - ImageListPresenter

    func testViewDidLoad() {

        presenter.viewDidLoad()

        XCTAssertEqual(mockInteractor.recordedInvocations.fetchImageList, 1)
        XCTAssertEqual(mockView.recordedInvocations.loading.count, 1)
        XCTAssertEqual(mockView.recordedInvocations.loading.first?.title, Strings.ImageListView.titleForLoading)
        XCTAssertEqual(mockView.recordedInvocations.loading.first?.message, Strings.ImageListView.messageForLoading)
        XCTAssertEqual(mockView.recordedInvocations.loading.first?.sortType, SortByType.datePublished)
    }

    func testRefreshTable() {

        presenter.refreshTable()

        XCTAssertEqual(mockInteractor.recordedInvocations.fetchImageList, 1)
    }

    func testWillDisplayImage() {

        let url = URL(string: "https://www.flickr.com")!

        var recordedImage: UIImage? = nil
        let completion: ((UIImage) -> Void) = {
            (image) in
            recordedImage = image
        }

        presenter.willDisplayImage(from: url, with: completion)

        XCTAssertEqual(mockInteractor.recordedInvocations.loadImage.count, 1)
        XCTAssertEqual(mockInteractor.recordedInvocations.loadImage.first?.url, url)

        let expectedImage = #imageLiteral(resourceName: "tag-image")
        mockInteractor.recordedInvocations.loadImage.first?.completion(expectedImage)

        XCTAssert(expectedImage === recordedImage)
    }

    func testEndDisplayingImage() {

        let url = URL(string: "https://www.flickr.com")!

        presenter.endDisplayingImage(from: url)

        XCTAssertEqual(mockInteractor.recordedInvocations.cancelImage, [url])
    }

    func testEditTagsRequest() {

        let expectedEditTagsViewModel = EditTagsViewModel.Builder()
            .withTitle(Strings.ImageListView.EditTag.alertTitle)
            .withMessage(Strings.ImageListView.EditTag.alertMessage)
            .withTextFieldPlaceHolder(Strings.ImageListView.EditTag.textFieldPlaceHolder)
            .withButtonTitle(Strings.ImageListView.EditTag.buttonTitle)
            .withCancelButtonTitle(Strings.ImageListView.EditTag.cancelButtonTitle)
            .build()

        presenter.editTagsRequest()

        XCTAssertEqual(mockView.recordedInvocations.presentAlert.count, 1)
		XCTAssertEqual(mockView.recordedInvocations.presentAlert.first?.viewModel, expectedEditTagsViewModel)
        XCTAssertEqual(mockView.recordedInvocations.presentAlert.first?.animated, true)

        guard let completionBlock = mockView.recordedInvocations.presentAlert.first?.viewModel.completion else {

            XCTFail("Completion block not setup")
            return
        }

        let expectedNewTag = "expected new tag"
        completionBlock(expectedNewTag)

        XCTAssertEqual(mockInteractor.recordedInvocations.fetchImageListWithTags, [expectedNewTag])
        XCTAssertEqual(mockView.recordedInvocations.loading.first?.title, Strings.ImageListView.titleForLoading)
        XCTAssertEqual(mockView.recordedInvocations.loading.first?.message, Strings.ImageListView.messageForLoading)
        XCTAssertEqual(mockView.recordedInvocations.loading.first?.sortType, SortByType.datePublished)
    }

    func testSortBy() {

        let sortedBy = SortByType.dateTaken

        let item1 = DataFeed.Item.Builder()
            .withDateTaken(Date())
            .build()
        let item2 = DataFeed.Item.Builder()
            .withDateTaken(Date().addingTimeInterval(98789))
            .build()
        let dataFeed = DataFeed.Builder()
            .withItems([item1, item2])
            .build()
		presenter.didFetch(result: .success(dataFeed))
		mockView.reset()
		mockAdapter.reset()

        presenter.sortBy(.dateTaken)

        XCTAssertEqual(mockAdapter.recordedInvocations.convertDataFeed.count, 1)
        XCTAssertEqual(mockAdapter.recordedInvocations.convertDataFeed.first?.dataFeed, dataFeed)
        XCTAssertEqual(mockAdapter.recordedInvocations.convertDataFeed.first?.sortedBy, sortedBy)
        XCTAssertEqual(mockView.recordedInvocations.update, [mockAdapter.returnValues.convert])
    }

    // MARK: - ImageListInteractorOutput

    func testImageListInteractorOutput_DidFetchDateFeed_WithSuccess() {

        let dataFeed = DataFeed.Builder()
            .withFeedTitle("This is a presenter test")
            .build()

        presenter.didFetch(result: .success(dataFeed))

        XCTAssertEqual(mockAdapter.recordedInvocations.convertDataFeed.count, 1)
        XCTAssertEqual(mockAdapter.recordedInvocations.convertDataFeed.first?.dataFeed, dataFeed)
        XCTAssertEqual(mockAdapter.recordedInvocations.convertDataFeed.first?.sortedBy, SortByType.datePublished)
        XCTAssertEqual(mockView.recordedInvocations.update, [mockAdapter.returnValues.convert])
    }

    func testImageListInteractorOutput_DidFetchDataFeed_WithFailure() {

        let error = NetworkError.failedToLoadData(message: "Error")

        presenter.didFetch(result: .failure(error))

        XCTAssertEqual(mockAdapter.recordedInvocations.convertError.count, 1)
        XCTAssertEqual(mockView.recordedInvocations.updateFailed.first?.title, Strings.ImageListView.titleForError)
        XCTAssertEqual(mockView.recordedInvocations.updateFailed.first?.errorMessage, mockAdapter.returnValues.convertError)
    }
}
