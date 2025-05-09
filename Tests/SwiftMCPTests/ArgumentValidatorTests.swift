//
//  Copyright (c) 2025 Erio Daniel Díaz
//
//  This source file is part of the SwiftMCP open-source project.
//  Licensed under the MIT License. See LICENSE file in the project root for full license information.
//
//  DISCLAIMER:
//  This software is provided "as is", without warranty of any kind, express or implied,
//  including but not limited to the warranties of merchantability, fitness for a particular purpose,
//  and noninfringement. In no event shall the authors or copyright holders be liable for any claim,
//  damages or other liability, whether in an action of contract, tort or otherwise, arising from,
//  out of or in connection with the software or the use or other dealings in the software.
//

import XCTest
@testable import SwiftMCP

/// Unit tests for the ArgumentValidator utility, which checks if parameters match expected types and structures.
final class ArgumentValidatorTests: XCTestCase {
    /// Tests validation of parameters with valid simple types (int, string, bool).
    func testValidSimpleTypes() {
        let expected: [String: Any] = [
            "a": "int",
            "b": "string",
            "c": "bool"
        ]
        let params: [String: Any] = ["a": 1, "b": "ok", "c": false]
        let result = ArgumentValidator.validate(params: params, expected: expected)
        XCTAssertTrue(result.isValid)
        XCTAssertTrue(result.errors.isEmpty)
    }

    /// Tests validation of parameters with invalid simple types, expecting validation errors for each parameter.
    func testInvalidSimpleTypes() {
        let expected: [String: Any] = ["a": "int", "b": "string", "c": "bool"]
        let params: [String: Any] = ["a": "uno", "b": 2, "c": "no"]
        let result = ArgumentValidator.validate(params: params, expected: expected)
        XCTAssertFalse(result.isValid)
        XCTAssertTrue(result.errors.contains { $0.contains("a") })
        XCTAssertTrue(result.errors.contains { $0.contains("b") })
        XCTAssertTrue(result.errors.contains { $0.contains("c") })
    }

    /// Tests validation of a nested object with correct types for its properties.
    func testValidNestedObject() {
        let expected: [String: Any] = [
            "profile": [
                "type": "object",
                "properties": [
                    "name": ["type": "string"],
                    "age": ["type": "int"]
                ]
            ]
        ]
        let params: [String: Any] = ["profile": ["name": "Erio", "age": 33]]
        let result = ArgumentValidator.validate(params: params, expected: expected)
        XCTAssertTrue(result.isValid)
    }

    /// Tests validation of a nested object with incorrect types, expecting validation errors for each property.
    func testInvalidNestedObject() {
        let expected: [String: Any] = [
            "profile": [
                "type": "object",
                "properties": [
                    "name": ["type": "string"],
                    "age": ["type": "int"]
                ]
            ]
        ]
        let params: [String: Any] = ["profile": ["name": 42, "age": "treinta"]]
        let result = ArgumentValidator.validate(params: params, expected: expected)
        XCTAssertFalse(result.isValid)
        XCTAssertTrue(result.errors.contains { $0.contains("profile.name") })
        XCTAssertTrue(result.errors.contains { $0.contains("profile.age") })
    }

    /// Tests validation of an array of objects where all objects have valid types for their properties.
    func testValidArrayOfObjects() {
        let expected: [String: Any] = [
            "items": [
                "type": "array",
                "items": [
                    "type": "object",
                    "properties": [
                        "id": ["type": "int"],
                        "label": ["type": "string"]
                    ]
                ]
            ]
        ]
        let params: [String: Any] = [
            "items": [
                ["id": 1, "label": "a"],
                ["id": 2, "label": "b"]
            ]
        ]
        let result = ArgumentValidator.validate(params: params, expected: expected)
        XCTAssertTrue(result.isValid)
    }

    /// Tests validation of an array of objects where at least one object has invalid property types, expecting validation errors.
    func testInvalidArrayOfObjects() {
        let expected: [String: Any] = [
            "items": [
                "type": "array",
                "items": [
                    "type": "object",
                    "properties": [
                        "id": ["type": "int"],
                        "label": ["type": "string"]
                    ]
                ]
            ]
        ]
        let params: [String: Any] = [
            "items": [
                ["id": 1, "label": "a"],
                ["id": "dos", "label": 2]
            ]
        ]
        let result = ArgumentValidator.validate(params: params, expected: expected)
        print("Errores en testInvalidArrayOfObjects:", result.errors)
        XCTAssertFalse(result.isValid)
        XCTAssertTrue(result.errors.contains { $0.contains("items[1].id") })
        XCTAssertTrue(result.errors.contains { $0.contains("items[1].label") })
    }

    func testMissingProperties() {
        let expected: [String: Any] = [
            "profile": [
                "type": "object",
                "properties": [
                    "name": ["type": "string"],
                    "age": ["type": "int"]
                ]
            ]
        ]
        let params: [String: Any] = ["profile": ["name": "Erio"]] // falta age
        let result = ArgumentValidator.validate(params: params, expected: expected)
        XCTAssertFalse(result.isValid)
        XCTAssertTrue(result.errors.contains { $0.contains("profile.age") })
    }
}
