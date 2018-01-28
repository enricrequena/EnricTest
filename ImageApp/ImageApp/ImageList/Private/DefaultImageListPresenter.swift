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

    func editTagsRequest() {

        let editTagViewModel = makeEditTagViewModel()

        view?.presentAlert(with: editTagViewModel, animated: true)
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

// MARK: - Helpers

extension DefaultImageListPresenter {

    private func makeEditTagViewModel() -> EditTagsViewModel {

        let editTagViewModel = EditTagsViewModel(
            title: Strings.ImageListView.EditTag.alertTitle,
            message: Strings.ImageListView.EditTag.alertMessage,
            textFieldPlaceHolder: Strings.ImageListView.EditTag.textFieldPlaceHolder,
            buttonTitle: Strings.ImageListView.EditTag.buttonTitle,
            cancelButtonTitle: Strings.ImageListView.EditTag.cancelButtonTitle) {

            tags in

            self.interactor.fetchImageList(with: tags)
        }

		return editTagViewModel
    }
}
