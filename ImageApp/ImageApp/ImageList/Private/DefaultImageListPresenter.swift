//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

class DefaultImageListPresenter {

    let interactor: ImageListInteractor
    let adapter: DataFeedToImageListViewModelAdapter
    weak var view: ImageListView?
    let wireframe: ImageListWireframe

    init(
        interactor: ImageListInteractor,
        adapter: DataFeedToImageListViewModelAdapter,
        view: ImageListView,
        wireframe: ImageListWireframe) {

        self.interactor = interactor
        self.adapter = adapter
        self.view = view
        self.wireframe = wireframe
    }
}

// MARK: - ImageListPresenter

extension DefaultImageListPresenter: ImageListPresenter {

    func viewDidLoad() {

        interactor.fetchImageList()

        view?.loading(with: Strings.ImageListView.titleForLoading, and: Strings.ImageListView.messageForLoading)
    }

    func refreshTable() {

        interactor.fetchImageList()
    }

    func willDisplayImage(from url: URL, with completion: @escaping (UIImage) -> Void) {

        interactor.loadImage(from: url, with: completion)
    }

    func endDisplayingImage(from url: URL) {

        interactor.cancelImage(from: url)
    }
}

// MARK: - ImageListInteractorOutput

extension DefaultImageListPresenter: ImageListInteractorOutput {

    func didFetch(result: Result<DataFeed>) {

        switch result {

            case let .success(dataFeed):

                let viewModel = adapter.convert(dataFeed: dataFeed)
                view?.update(with: viewModel)

            case let .failure(error):

                let errorMessage = adapter.convert(error: error)
                view?.updateFailed(with: Strings.ImageListView.titleForError, and: errorMessage)

        }
    }
}