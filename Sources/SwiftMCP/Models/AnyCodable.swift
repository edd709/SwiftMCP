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

import Foundation

/// A type-erased wrapper that enables encoding and decoding of any JSON-compatible value using Codable.
///
/// This struct can store and transport any value that is compatible with JSON: numbers, strings, booleans, arrays, dictionaries, and null (`nil`) values.
/// It is useful for MCP model fields where the data type is arbitrary or dynamic.
/// Supports correct serialization and deserialization of null (`nil`) values.
/// Throws an encoding error if an unsupported type is serialized.
///
/// ### Example usage:
/// ```swift
/// let value: AnyCodable = AnyCodable(["key": 123, "active": true, "comment": nil])
/// let data = try JSONEncoder().encode(value)
/// ```
public struct AnyCodable: Codable {
    /// The underlying value stored by this wrapper. This can be any JSON-compatible type.
    public let value: Any

    /// Creates a new `AnyCodable` instance wrapping the given value.
    /// - Parameter value: Any JSON-compatible value to wrap.
    public init(_ value: Any) {
        self.value = value
    }

    /// Decodes a value from the given decoder.
    /// Attempts to decode as Bool, Int, Double, String, Array, Dictionary, or nil in that order.
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: `DecodingError` if the value cannot be decoded as a supported type.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self.value = ()
        } else if let bool = try? container.decode(Bool.self) {
            self.value = bool
        } else if let int = try? container.decode(Int.self) {
            self.value = int
        } else if let double = try? container.decode(Double.self) {
            self.value = double
        } else if let string = try? container.decode(String.self) {
            self.value = string
        } else if let array = try? container.decode([AnyCodable].self) {
            self.value = array.map { $0.value }
        } else if let dict = try? container.decode([String: AnyCodable].self) {
            self.value = dict.mapValues { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "AnyCodable value cannot be decoded")
        }
    }

    /// Encodes the wrapped value to the given encoder.
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: `EncodingError` if the value cannot be encoded as a supported type.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try AnyCodable.encode(value: self.value, into: &container)
    }

    /// Encodes the given value into the provided single value encoding container.
    /// Handles optionals, nulls, and all supported JSON types.
    /// - Parameters:
    ///   - value: The value to encode.
    ///   - container: The encoding container to write to.
    /// - Throws: `EncodingError` if the value cannot be encoded.
    private static func encode(value: Any, into container: inout SingleValueEncodingContainer) throws {
        // Detect optionals nil and serialize as null
        let mirror = Mirror(reflecting: value)
        if mirror.displayStyle == .optional && mirror.children.count == 0 {
            try container.encodeNil()
            return
        }
        switch value {
        case is Void:
            try container.encodeNil()
        case let bool as Bool:
            try container.encode(bool)
        case let int as Int:
            try container.encode(int)
        case let double as Double:
            try container.encode(double)
        case let string as String:
            try container.encode(string)
        case let array as [Any]:
            let encodableArray = array.map { AnyCodable($0) }
            try container.encode(encodableArray)
        case let dict as [String: Any]:
            let encodableDict = dict.mapValues { AnyCodable($0) }
            try container.encode(encodableDict)
        case let anyCodable as AnyCodable:
            try encode(value: anyCodable.value, into: &container)
        default:
            let context = EncodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "AnyCodable value cannot be encoded"
            )
            throw EncodingError.invalidValue(value, context)
        }
    }
}

/// Conformance to Equatable for testing purposes.
///
/// Note: This implementation always returns false. You may improve it to suit your needs.
extension AnyCodable: Equatable {
    /// Checks if two `AnyCodable` instances are equal.
    /// - Parameters:
    ///   - lhs: The left-hand side instance.
    ///   - rhs: The right-hand side instance.
    /// - Returns: A boolean indicating whether the instances are equal.
    public static func == (lhs: AnyCodable, rhs: AnyCodable) -> Bool {
        // Simple implementation: always returns false (customize as needed)
        return false
    }
}
