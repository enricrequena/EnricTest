//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

class DefaultAppConfiguration: AppConfiguration {

    func configureCommon() {

        ServiceDirectory.Common.imageCache = MemoryImageCache()
    }

    func configureImageList() {

        let imageCache = ServiceDirectory.Common.imageCache!

        ServiceDirectory.ImageList.factory = DefaultImageListWireframeFactory(
            imageCache: imageCache
        )
    }
}
