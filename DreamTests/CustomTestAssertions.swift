//
//  TestAssertions.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/3/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest

struct UnexpectedNilValueError: Error {}

func JTAssertNotNilAndUnwrap<T>(_ value: T?, message: String = "Unexpected nil value", file: StaticString = #file, line: UInt = #line) throws -> T {
    guard let value = value else {
        XCTFail(message, file: file, line: line)
        throw UnexpectedNilValueError()
    }
    return value
}
