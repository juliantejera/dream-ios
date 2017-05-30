//
//  NetworkClientResultAssertions.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

@testable import Dream
import XCTest

func JTAssertNetworkClientResultSucceeds<T>(_ result: NetworkClientResult<T>) {
    switch result {
    case .success(_):
        XCTAssert(true)
    case .failure(_):
        XCTFail("Expected NetworkClientResult to succeed")
    }
}

func JTAssertNetworkClientResultFails<T>(_ result: NetworkClientResult<T>) {
    switch result {
    case .success(_):
        XCTFail("Expected NetworkClientResult to fail")
    case .failure(_):
        XCTAssert(true)
    }
}
