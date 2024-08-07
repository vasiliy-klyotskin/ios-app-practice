//
//  XCTestCase+MemoryLeakTracking.swift
//  Pokepedia-iOS-AppTests
//
//  Created by Vasiliy Klyotskin on 5/29/23.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(
        _ instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
