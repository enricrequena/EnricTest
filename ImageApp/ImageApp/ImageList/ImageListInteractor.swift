//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

protocol ImageListInteractor: class {

    func fetchImageList()
    func fetchImageList(with tags: String)
    func loadImage(from url: URL, with completion: @escaping (UIImage) -> Void)
    func cancelImage(from url: URL)

}

protocol ImageListInteractorOutput: class {

    func didFetch(result: Result<DataFeed>)
}
