//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

enum SortByType {

    case dateTaken
    case datePublished
}

enum Action {

    case saveToLibrary(buttonTitle: String, item: ImageListViewModel.Item, action: (UIImage) -> Void)
    case cancel(buttonTitle: String)
}

extension Action: Equatable {

    static func ==(lhs: Action, rhs: Action) -> Bool {
        switch (lhs, rhs) {
        case let (.saveToLibrary(buttonTitle:l0, item:l1, action:l2), .saveToLibrary(buttonTitle:r0, item:r1, action:r2)):
            return l0 == r0 && l1 == r1
        case let (.cancel(buttonTitle:l0), .cancel(buttonTitle:r0)):
            return l0 == r0
        default:
            return false
        }
    }
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

            self.view?.loading(
                with: Strings.ImageListView.titleForLoading,
                and: Strings.ImageListView.messageForLoading,
                sortType: self.sortByType
            )

            self.interactor.fetchImageList(with: tags)
        }

        return editTagViewModel
    }

    private func sortAndUpdateView(with dataFeed: DataFeed?, by type: SortByType) {

        guard let dataFeed = dataFeed else {

            return
        }

        let viewModel = adapter.convert(
            dataFeed: dataFeed,
            sortedBy: type,
            itemAction: {
                item in
                self.presentActions(for: item)
            }
        )
        view?.update(with: viewModel)
    }
}

// MARK: - Action Helpers

extension DefaultImageListPresenter {

    private func presentActions(for item: ImageListViewModel.Item) {

        let saveToLibraryCompletion: (Error?) -> Void = {

            [weak self] (error: Error?) in

			guard let strongSelf = self else {

				return
			}

            guard error == nil else {

                let failureToastMessage = Strings.ImageListView.Action.failureSavingImageToastMessage
				let errorColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1.0)
				strongSelf.view?.presentToast(with: failureToastMessage, and: errorColor)
                return
            }

            let toastSuccessMessage = Strings.ImageListView.Action.successImageSavedToastMessage
			let successColor = UIColor(red: 0, green: 0.65, blue: 0, alpha: 1.0)
			strongSelf.view?.presentToast(with: toastSuccessMessage, and: successColor)
        }

        let saveToLibraryButtonTitle = Strings.ImageListView.Action.saveToLibraryButtonTitle
        let saveToLibraryAction: (UIImage) -> Void = {
            image in
			self.interactor.saveToLibrary(image, completion: saveToLibraryCompletion)
        }

        let cancelButtonTitle = Strings.ImageListView.Action.cancelButtonTitle

        let actions: [Action] = [
            .saveToLibrary(buttonTitle: saveToLibraryButtonTitle, item: item, action: saveToLibraryAction),
            .cancel(buttonTitle: cancelButtonTitle)
        ]

        let alertTitle = Strings.ImageListView.Action.alertTitle
        let alertMessage = Strings.ImageListView.Action.alertMessage

        let viewModel = ActionsViewModel(title: alertTitle, message: alertMessage, actions: actions)
        view?.presentActions(with: viewModel, animated: true)
    }
}
