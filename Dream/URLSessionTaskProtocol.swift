//
//  URLSessionTaskProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/27/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

protocol URLSessionTaskProtocol: Cancellable, Suspendable, Resumable {
    var taskIdentifier: Int { get }
    var state: URLSessionTask.State { get }
}

extension URLSessionTask: URLSessionTaskProtocol {}
