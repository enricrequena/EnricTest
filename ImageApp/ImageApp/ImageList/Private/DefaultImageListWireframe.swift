//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

class DefaultImageListWireframe {

    let viewController: ImageListViewController

    init(viewController: ImageListViewController) {

        self.viewController = viewController
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
        let interactor = DefaultImageListInteractor()

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