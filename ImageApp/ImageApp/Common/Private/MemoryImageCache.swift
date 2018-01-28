//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

class MemoryImageCache {

    private let cache = NSCache<AnyObject, UIImage>()
}

extension MemoryImageCache: ImageCache {

    func cache(image: UIImage, at url: URL) {

        guard let key = url.absoluteString as? AnyObject else {

            return
        }

        cache.setObject(image, forKey: key)
    }

    func findImage(for url: URL) -> UIImage? {

        guard let key = url.absoluteString as? AnyObject else {

            return nil
        }

        return cache.object(forKey: key) as? UIImage
    }
}