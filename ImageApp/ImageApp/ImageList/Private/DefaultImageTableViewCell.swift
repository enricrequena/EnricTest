//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

class DefaultImageTableViewCell: UITableViewCell {

    static let reuseIdentifier = "DefaultImageTableViewCell"

    @IBOutlet weak var publishedAt: UILabel!
    @IBOutlet weak var _imageView: UIImageView!
	@IBOutlet weak var actionsButton: UIButton!

    private var item: ImageListViewModel.Item? = nil

    func update(with item: ImageListViewModel.Item) {

        self.item = item

        publishedAt.text = item.dateInfo
    }
}

extension DefaultImageTableViewCell {

    @IBAction func itemActionTapped() {

        guard let item = item else {

            return
        }

        item.itemAction?(item)
    }
}
