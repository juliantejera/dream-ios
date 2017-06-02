//
//  SignInViewModelSerializerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class SignInViewModelSerializerTests: XCTestCase {
    
    func testSerialize() {
        let viewModel = SignInViewModel.create()
        let dictionary = SignInViewModelSerializer().serialize(from: viewModel)
        XCTAssertEqual(viewModel.email, dictionary["email"] as? String)
        XCTAssertEqual(viewModel.password, dictionary["password"] as? String)
    }
    
}
