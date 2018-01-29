//
//  Copyright © 2018 ERT Limited. All rights reserved.
//

import UIKit

class ShareImageActivityItemSource: NSObject {

	let image: UIImage

	init(image: UIImage) {

		self.image = image

		super.init()
	}
}

extension ShareImageActivityItemSource: UIActivityItemSource {

	func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {

		return image
	}

	func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType?) -> Any? {

		return image
	}
}

