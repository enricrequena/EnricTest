//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

class DefaultAppConfiguration: AppConfiguration {

    func configureCommon() {

        ServiceDirectory.Common.imageCache = MemoryImageCache()
        ServiceDirectory.Common.imageLibrary = SystemGalleryImageLibrary()
    }

    func configureImageList() {

        let imageCache = ServiceDirectory.Common.imageCache!
        let imageLibrary = ServiceDirectory.Common.imageLibrary!

        ServiceDirectory.ImageList.factory = DefaultImageListWireframeFactory(
            imageCache: imageCache,
            imageLibrary: imageLibrary
        )
    }
}
