//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

protocol ImageLibrary: class {

    func save(image: UIImage, completion: ((Error?) -> Void)?)
}
