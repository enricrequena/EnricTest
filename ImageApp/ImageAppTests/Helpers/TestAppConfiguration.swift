//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

class TestAppConfiguration: DefaultAppConfiguration {

    override func configureCommon() {

        ServiceDirectory.Common.imageCache = MockImageCache()
    }

    override func configureImageList() {

        ServiceDirectory.ImageList.factory = MockImageListWireframeFactory()
    }
}