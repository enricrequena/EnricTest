//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

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

    func navigateToShare(with image: UIImage) {

        presentShare(with: image)
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

    private func presentShare(with image: UIImage) {

        let shareWireframe = DefaultShareWireframe(viewController: viewController)

        let shareImageActivityItemSource = ShareImageActivityItemSource(image: image)

        let context = ShareContext(activityItems: [shareImageActivityItemSource])

        shareWireframe.presentActivityController(context: context, animated: true)
    }
}
