//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

class DefaultImageListWireframeFactory {

    let imageCache: ImageCache
    let imageLibrary: ImageLibrary

    init(imageCache: ImageCache, imageLibrary: ImageLibrary) {

        self.imageCache = imageCache
        self.imageLibrary = imageLibrary
    }
}

extension DefaultImageListWireframeFactory: ImageListWireframeFactory {

    func makeWireframe(with viewController: ImageListViewController) -> ImageListWireframe {

        return DefaultImageListWireframe(
            viewController: viewController,
            imageCache: imageCache,
            imageLibrary: imageLibrary
        )
    }
}