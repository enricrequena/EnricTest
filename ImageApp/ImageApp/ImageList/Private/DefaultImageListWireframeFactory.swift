//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

class DefaultImageListWireframeFactory {

    let imageCache: ImageCache

    init(imageCache: ImageCache) {

        self.imageCache = imageCache
    }
}

extension DefaultImageListWireframeFactory: ImageListWireframeFactory {

    func makeWireframe(with viewController: ImageListViewController) -> ImageListWireframe {

        return DefaultImageListWireframe(viewController: viewController, imageCache: imageCache)
    }
}