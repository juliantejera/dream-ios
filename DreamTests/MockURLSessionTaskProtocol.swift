//
//  MockURLSessionTaskProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/28/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

class MockURLSessionTaskProtocol: URLSessionTaskProtocol {
    var state: URLSessionTask.State = .running

    var cancelCallCount = 0
    func cancel() {
        cancelCallCount += 1
    }
    
    var resumeCallCount = 0
    func resume() {
        resumeCallCount += 1
    }
    
    var suspendCallCount = 0
    func suspend() {
        suspendCallCount += 1
    }
    
}
