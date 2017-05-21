//
//  XCTestCaseExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest

private class DreamTestClass {}

extension XCTestCase {
    
    private var bundle: Bundle {
        return Bundle(for: DreamTestClass.self)
    }
    
    func fixture(name: String) -> [String: Any] {
        
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            return [:]
        }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return json as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }
    
    func arrayFixture(name: String) -> [Any] {
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return json as? [Any] ?? []
        } catch {
            return []
        }
    }
}
