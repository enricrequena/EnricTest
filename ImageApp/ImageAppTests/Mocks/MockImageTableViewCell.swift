//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

class MockImageTableViewCell: DefaultImageTableViewCell {

    struct Invocations {

        var update = [ImageListViewModel.Item]()
    }
    var recordedInvocations = Invocations()

    override func update(with item: ImageListViewModel.Item) {

        recordedInvocations.update.append(item)
    }
}