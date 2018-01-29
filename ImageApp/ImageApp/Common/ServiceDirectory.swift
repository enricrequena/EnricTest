//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

class ServiceDirectory {

    enum Common {

        static var imageCache: ImageCache!
        static var imageLibrary: ImageLibrary!
    }

    enum ImageList {

        static var factory: ImageListWireframeFactory!
    }
}