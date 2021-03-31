//
//  Extensions.swift
//  Acronyms
//
//  Created by Cristian Palomino on 3/31/21.
//

import Foundation
import Combine

typealias Acronym = String

extension URLSession {

    static var api = URLSession.shared

    func send(with acronym: Acronym) -> AnyPublisher<[Response], ApiError> {
        let string = "http://nactem.ac.uk/software/acromine/dictionary.py?sf=\(acronym)"
        guard let url = URL(string: string) else { fatalError("Must be a valid string") }
        let json = JSONDecoder()
        return dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .tryMap(\.data)
            .decode(type: [Response].self, decoder: json)
            .mapError(ApiError.general)
            .eraseToAnyPublisher()
    }

}

enum ApiError: Error, Equatable {

    case empty
    case general(Error)

    var message: String {
        switch self {
        case .empty: return "Acronym not found"
        case let .general(error): return error.localizedDescription
        }
    }

    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        return lhs.message == rhs.message
    }

}
