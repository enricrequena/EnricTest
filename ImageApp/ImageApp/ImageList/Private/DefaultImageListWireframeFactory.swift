//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

class DefaultImageListWireframeFactory {

}

extension DefaultImageListWireframeFactory: ImageListWireframeFactory {

    func makeWireframe(with viewController: ImageListViewController) -> ImageListWireframe {

        return DefaultImageListWireframe(viewController: viewController)
    }
}