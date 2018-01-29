//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

class DefaultImageListWireframe {

    let viewController: ImageListViewController
    let imageCache: ImageCache
    let imageLibrary: ImageLibrary

    init(viewController: ImageListViewController, imageCache: ImageCache, imageLibrary: ImageLibrary) {

        self.viewController = viewController
        self.imageCache = imageCache
        self.imageLibrary = imageLibrary
    }
}

// MARK: - ImageListWireframe

extension DefaultImageListWireframe: ImageListWireframe {

    func present() {

        wireUpModule()
    }
}

// MARK: - Helper methods

extension DefaultImageListWireframe {

    private func wireUpModule() {

        let adapter = DefaultDataFeedToImageListViewModelAdapter()
        let interactor = DefaultImageListInteractor(imageCache: imageCache, imageLibrary: imageLibrary)

        let presenter = DefaultImageListPresenter(
            interactor: interactor,
            adapter: adapter,
            view: viewController,
            wireframe: self
        )
        interactor.output = presenter

        viewController.presenter = presenter
    }
}