//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

enum SortByType {

    case dateTaken
    case datePublished
}

class DefaultImageListPresenter {

    let interactor: ImageListInteractor
    let adapter: DataFeedToImageListViewModelAdapter
    weak var view: ImageListView?
    let wireframe: ImageListWireframe

    private var sortByType: SortByType = .datePublished
    private var dataFeed: DataFeed? = nil

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

        view?.loading(
			with: Strings.ImageListView.titleForLoading,
			and: Strings.ImageListView.messageForLoading,
			sortType: sortByType
		)
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

    func sortBy(_ type: SortByType) {

        sortByType = type
        sortAndUpdateView(with: dataFeed, by: sortByType)
    }
}

// MARK: - ImageListInteractorOutput

extension DefaultImageListPresenter: ImageListInteractorOutput {

    func didFetch(result: Result<DataFeed>) {

        switch result {

            case let .success(dataFeed):

                self.dataFeed = dataFeed
                sortAndUpdateView(with: dataFeed, by: sortByType)

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

    private func sortAndUpdateView(with dataFeed: DataFeed?, by type: SortByType) {

        guard let dataFeed = dataFeed else {

            return
        }

        let viewModel = adapter.convert(dataFeed: dataFeed, sortedBy: type)

        view?.update(with: viewModel)
    }
}
