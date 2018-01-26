//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

protocol ImageListWireframeFactory: class {

    func makeWireframe(with viewController: ImageListViewController) -> ImageListWireframe
}