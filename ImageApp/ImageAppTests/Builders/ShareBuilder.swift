//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

import UIKit

extension ShareContext {

    struct Builder {

        var activityItems: [UIActivityItemSource] = []

        func withActivityItems(_ activityItems: [UIActivityItemSource]) -> Builder {
            var builder = self
            builder.activityItems = activityItems
            return builder
        }

        func build() -> ShareContext {
            return ShareContext(
                activityItems: self.activityItems)
        }
    }

}