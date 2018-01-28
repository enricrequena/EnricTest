//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

protocol ImageListPresenter: class {

    func viewDidLoad()
    func refreshTable()
    func willDisplayImage(from url: URL, with completion: @escaping (UIImage) -> Void)
    func endDisplayingImage(from url: URL)
    func editTagsRequest()
    func sortBy(_ type: SortByType)
}
