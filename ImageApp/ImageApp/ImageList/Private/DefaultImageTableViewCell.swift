//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

class DefaultImageTableViewCell: UITableViewCell {

    static let reuseIdentifier = "DefaultImageTableViewCell"

    @IBOutlet weak var publishedAt: UILabel!
    @IBOutlet weak var _imageView: UIImageView!

    func update(with item: ImageListViewModel.Item) {

        publishedAt.text = item.dateInfo
    }
}