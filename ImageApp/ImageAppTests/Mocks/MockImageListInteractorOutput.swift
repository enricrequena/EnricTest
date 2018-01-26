//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

class MockImageListInteractorOutput {

    struct Invocations {

        var didFetch = [Result<DataFeed>]()
    }
    var recordedInvocations = Invocations()

    struct ExecuteOnCall {

        var didFetch: (() -> Void)? = nil
    }
    var executeOnCall = ExecuteOnCall()
}

extension MockImageListInteractorOutput: ImageListInteractorOutput {

    func didFetch(result: Result<DataFeed>) {

        recordedInvocations.didFetch.append(result)

        executeOnCall.didFetch?()
    }
}
