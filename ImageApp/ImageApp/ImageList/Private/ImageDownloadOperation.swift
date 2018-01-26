//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift

class ImageDownloadOperation: Operation {

    let url: URL
    private let completion: (UIImage) -> Void

    init(url: URL, completion: @escaping (UIImage) -> Void) {

        self.url = url
        self.completion = completion

        super.init()
    }

    override func main() {

        guard !isCancelled else {

            return
        }

        guard Reachability()?.isReachable == true else {

            return
        }

        guard let data = try? Data(contentsOf: url) else {

            return
        }

        guard !isCancelled else {

            return
        }

        guard let image = UIImage(data: data) else {

            return
        }

        guard !isCancelled else {

            return
        }

        completion(image)
    }
}
