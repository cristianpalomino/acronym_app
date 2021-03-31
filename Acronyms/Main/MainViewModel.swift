//
//  MainViewModel.swift
//  Acronyms
//
//  Created by Cristian Palomino on 3/31/21.
//

import Foundation
import Combine

protocol MainViewModelProtocol {

    var pushResults: (([LongForm]) -> Void)? { get set }
    var presentError: ((ApiError) -> Void)? { get set }
    func didTapSearch(acronym: String)

}

class MainViewModel: MainViewModelProtocol {

    var pushResults: (([LongForm]) -> Void)? = { _ in }
    var presentError: ((ApiError) -> Void)? = { _ in }

    var cancellable: AnyCancellable?

    func didTapSearch(acronym: String) {
        cancellable = URLSession.api.send(with: acronym)
            .tryMap { response -> Response in
                if let first = response.first {
                    return first
                }
                throw ApiError.empty
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
            switch result {
            case .finished: break
            case let .failure(error): self.presentError?(error as! ApiError)
            }
        }, receiveValue: { (response) in
            self.pushResults?(response.lfs)
        })
    }

    func obtainFirst(of responses: [Response]) throws -> Response {
        if let first = responses.first {
            return first
        }
        throw ApiError.empty
    }

}
