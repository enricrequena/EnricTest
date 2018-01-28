//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

protocol ImageCache: class {

    func cache(image: UIImage, at url: URL)
    func findImage(for url: URL) -> UIImage?
}