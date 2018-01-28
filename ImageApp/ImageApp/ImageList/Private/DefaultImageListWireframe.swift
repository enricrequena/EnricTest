//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

class DefaultImageListWireframe {

    let viewController: ImageListViewController
    let imageCache: ImageCache

    init(viewController: ImageListViewController, imageCache: ImageCache) {

        self.viewController = viewController
        self.imageCache = imageCache
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
        let interactor = DefaultImageListInteractor(imageCache: imageCache)

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