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
    }

    func refreshTable() {

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

        let expectedImage = #imageLiteral(resourceName: "options-icon")
        mockInteractor.recordedInvocations.loadImage.first?.completion(expectedImage)

        XCTAssert(expectedImage === recordedImage)
    }

    func testEndDisplayingImage() {

        let url = URL(string: "https://www.flickr.com")!

        presenter.endDisplayingImage(from: url)

        XCTAssertEqual(mockInteractor.recordedInvocations.cancelImage, [url])
    }

    // MARK: - ImageListInteractorOutput

    func testImageListInteractorOutput_DidFetchDateFeed_WithSuccess() {

        let dataFeed = DataFeed.Builder()
            .withFeedTitle("This is a presenter test")
            .build()

        presenter.didFetch(result: .success(dataFeed))

        XCTAssertEqual(mockAdapter.recordedInvocations.convertDataFeed, [dataFeed])
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
