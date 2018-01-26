//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

enum NetworkError: Error {

    case failedToLoadData(message: String)
}

extension NetworkError: Equatable {

    static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case let (.failedToLoadData(message:l0), .failedToLoadData(message:r0)):
            return l0 == r0
        }
    }
}
