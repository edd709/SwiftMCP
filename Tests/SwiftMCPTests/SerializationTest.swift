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

import Testing
import Foundation
import SwiftMCP

/// Custom error type for serialization test failures.
struct TestFailure: Error, CustomStringConvertible {
    let description: String
    init(_ description: String) { self.description = description }
}

/// Unit tests for serialization and deserialization of SwiftMCP types.
struct SerializationTests {

    @Test
    /// Tests serialization and deserialization of an MCPMessage with annotations.
    /// Expects the role and priority to be correctly encoded and decoded.
    func mcpMessageSerialization() throws {
        let annotations = Annotations(audience: ["user"], priority: 1.0)
        let message = MCPMessage(role: "user", content: AnyCodable("Hello world"), annotations: annotations)
        let encoder = JSONEncoder()
        let data = try encoder.encode(message)
        let jsonString = String(data: data, encoding: .utf8)!
        print("Serialized MCPMessage:", jsonString)

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(MCPMessage.self, from: data)
        #expect(decoded.role == "user")
        #expect(decoded.annotations?.priority == 1.0)
    }

    @Test
    /// Tests serialization and deserialization of an array of AnyCodable values.
    /// Expects the array to be correctly encoded and decoded with all its elements.
    func anyCodableArraySerialization() throws {
        let array: [AnyCodable] = [AnyCodable("texto"), AnyCodable(42), AnyCodable(true)]
        let value = AnyCodable(array)
        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        guard let arr = decoded.value as? [Any] else { throw TestFailure("Not an array") }
        #expect(arr.count == 3)
    }

    @Test
    /// Tests serialization and deserialization of a nested dictionary of AnyCodable values.
    /// Expects the nested structure to be preserved after encoding and decoding.
    func anyCodableNestedDictionarySerialization() throws {
        let nested: [String: AnyCodable] = [
            "level1": AnyCodable([
                "level2": AnyCodable([
                    "value": AnyCodable(123)
                ])
            ])
        ]
        let value = AnyCodable(nested)
        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        guard let dict = decoded.value as? [String: Any] else { throw TestFailure("Not a dictionary") }
        #expect(dict["level1"] != nil)
    }

    @Test
    /// Tests serialization and deserialization of a nil AnyCodable value.
    /// Expects the decoded value to be Void.
    func anyCodableNilSerialization() throws {
        let value = AnyCodable(Optional<String>.none as Any)
        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        #expect(decoded.value is Void)
    }

    @Test
    /// Tests serialization and deserialization of an MCPResponse.
    /// Expects the id and result to be preserved after encoding and decoding.
    func mcpResponseSerialization() throws {
        let result: [String: AnyCodable] = [
            "output": AnyCodable("response"),
            "confidence": AnyCodable(0.99)
        ]
        let response = MCPResponse(id: "1", result: AnyCodable(result))
        let data = try JSONEncoder().encode(response)
        let decoded = try JSONDecoder().decode(MCPResponse.self, from: data)
        #expect(decoded.id == "1")
    }

    @Test
    /// Tests serialization and deserialization of an MCPError.
    /// Expects the code, message, and data fields to be preserved after encoding and decoding.
    func mcpErrorSerialization() throws {
        let dataField: [String: AnyCodable] = [
            "reason": AnyCodable("not_found"),
            "retryable": AnyCodable(false)
        ]
        let error = MCPError(code: 404, message: "Not found", data: dataField)
        let encoded = try JSONEncoder().encode(error)
        let decoded = try JSONDecoder().decode(MCPError.self, from: encoded)
        #expect(decoded.code == 404)
        #expect(decoded.message == "Not found")
    }

    @Test
    /// Tests serialization and deserialization of an empty AnyCodable array.
    /// Expects the decoded array to be empty.
    func anyCodableEmptyArray() throws {
        let value = AnyCodable([AnyCodable]())
        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        guard let arr = decoded.value as? [Any] else { throw TestFailure("Not an array") }
        guard arr.count == 0 else { throw TestFailure("Element count is not 0") }
    }

    @Test
    /// Tests serialization and deserialization of an empty AnyCodable dictionary.
    /// Expects the decoded dictionary to be empty.
    func anyCodableEmptyDictionary() throws {
        let value = AnyCodable([String: AnyCodable]())
        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        guard let dict = decoded.value as? [String: Any] else { throw TestFailure("Not a dictionary") }
        guard dict.count == 0 else { throw TestFailure("Element count is not 0") }
    }

    @Test
    /// Tests serialization and deserialization of dictionaries with long and empty string keys.
    /// Expects both keys to be present after decoding.
    func anyCodableLongAndEmptyKeys() throws {
        let longKey = String(repeating: "a", count: 1024)
        let dict: [String: AnyCodable] = ["": AnyCodable(1), longKey: AnyCodable(2)]
        let value = AnyCodable(dict)
        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        guard let result = decoded.value as? [String: Any] else { throw TestFailure("Not a dictionary") }
        guard result[""] != nil else { throw TestFailure("Empty key does not exist") }
        guard result[longKey] != nil else { throw TestFailure("Long key does not exist") }
    }

    @Test
    /// Tests serialization and deserialization of extreme integer and double values in AnyCodable.
    /// Expects Int.max, Int.min, and Double extreme values to be preserved after decoding.
    func anyCodableExtremeNumbers() throws {
        let dict: [String: AnyCodable] = [
            "maxInt": AnyCodable(Int.max),
            "minInt": AnyCodable(Int.min),
            "maxDouble": AnyCodable(Double.greatestFiniteMagnitude),
            "minDouble": AnyCodable(-Double.greatestFiniteMagnitude)
        ]
        let value = AnyCodable(dict)
        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        guard let result = decoded.value as? [String: Any] else { throw TestFailure("Not a dictionary") }
        guard result["maxInt"] as? Int == Int.max else { throw TestFailure("Maximum integer is not correct") }
        guard result["minInt"] as? Int == Int.min else { throw TestFailure("Minimum integer is not correct") }
    }

    @Test
    /// Tests that JSONEncoder fails to encode NaN and Infinity values in AnyCodable.
    /// Expects encoding to fail for these special float values.
    func anyCodableSpecialFloats() throws {
        let dict: [String: AnyCodable] = [
            "nan": AnyCodable(Double.nan),
            "infinity": AnyCodable(Double.infinity),
            "negInfinity": AnyCodable(-Double.infinity)
        ]
        let value = AnyCodable(dict)
        let data = try? JSONEncoder().encode(value)
        guard data == nil else { throw TestFailure("JSONEncoder can serialize NaN or Infinity") }
    }

    @Test
    /// Tests serialization and deserialization of boolean values in AnyCodable.
    /// Expects both true and false to be preserved after decoding.
    func anyCodableBooleans() throws {
        let dict: [String: AnyCodable] = ["true": AnyCodable(true), "false": AnyCodable(false)]
        let value = AnyCodable(dict)
        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
        guard let result = decoded.value as? [String: Any] else { throw TestFailure("Not a dictionary") }
        guard result["true"] as? Bool == true else { throw TestFailure("Boolean true is not correct") }
        guard result["false"] as? Bool == false else { throw TestFailure("Boolean false is not correct") }
        #expect(result["true"] as? Bool == true)
        #expect(result["false"] as? Bool == false)
    }

    @Test
    /// Tests serialization and deserialization of an MCPMessage with nil annotations.
    /// Expects annotations to be nil after decoding.
    func mcpMessageOptionalAnnotationsNil() throws {
        let message = MCPMessage(role: "user", content: AnyCodable("Hello"), annotations: nil)
        let data = try JSONEncoder().encode(message)
        let decoded = try JSONDecoder().decode(MCPMessage.self, from: data)
        #expect(decoded.annotations == nil)
    }

    @Test
    /// Tests that decoding malformed JSON throws an error.
    /// Expects an error to be thrown for invalid JSON input.
    func deserializeMalformedJSON() {
        let malformed = "{".data(using: .utf8)!
        var thrown = false
        do {
            _ = try JSONDecoder().decode(AnyCodable.self, from: malformed)
        } catch {
            thrown = true
        }
        #expect(thrown)
    }

    @Test
    /// Tests that encoding an unsupported type in AnyCodable throws an error.
    /// Expects encoding to fail for types that do not conform to Codable.
    func anyCodableUnsupportedType() {
        struct NotCodable {}
        let value = AnyCodable(NotCodable())
        let encoder = JSONEncoder()
        var thrown = false
        do {
            _ = try encoder.encode(value)
        } catch {
            thrown = true
        }
        #expect(thrown)
    }

    @Test
    func mcpRequestSerialization() throws {
        let params: [String: AnyCodable] = [
            "prompt": AnyCodable("Hello"),
            "max_tokens": AnyCodable(10)
        ]
        let request = MCPRequest(id: "1", method: "completion/complete", params: AnyCodable(params))
        let data = try JSONEncoder().encode(request)
        let decoded = try JSONDecoder().decode(MCPRequest.self, from: data)
        #expect(decoded.method == "completion/complete")
    }
}
