//
//  AcronymsTests.swift
//  AcronymsTests
//
//  Created by Cristian Palomino on 3/31/21.
//

import XCTest
@testable import Acronyms

class AcronymsTests: XCTestCase {

    let sut = MainViewModel()

    func testObtainFirstWithValue() throws {
        let mock = [Response(lfs: [LongForm(lf: "Test", vars: nil)]), Response(lfs: [LongForm(lf: "Test", vars: nil)])]
        let result = try sut.obtainFirst(of: mock)
        XCTAssertNotNil(result, "Result value must not be nil")
    }

    func testObtainFirstWithError() throws {
        let mock: [Response] = []
        var thrownError: Error?
        // Capture the thrown error using a closure
        XCTAssertThrowsError(try sut.obtainFirst(of: mock)) {
            thrownError = $0
        }
        // First we’ll verify that the error is of the right
        // type, to make debugging easier in case of failures.
        XCTAssertTrue(
            thrownError is ApiError,
            "Unexpected error type: \(type(of: thrownError))"
            )
        // Verify that our error is equal to what we expect
        XCTAssertEqual(thrownError as? ApiError, ApiError.empty)
    }

}
