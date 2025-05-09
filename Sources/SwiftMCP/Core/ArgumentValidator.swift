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

/// Represents the result of a parameter validation process, including validity, error messages, and detailed validation errors.
public struct ValidationResult {
    /// Indicates whether the validation was successful (true) or failed (false).
    public let isValid: Bool
    /// A list of error messages describing validation failures in human-readable form.
    public let errors: [String]
    /// A list of detailed validation errors conforming to MCPErrorProtocol.
    public let validationErrors: [MCPValidationError]

    /// Initializes a new ValidationResult.
    /// - Parameters:
    ///   - isValid: Boolean indicating if validation passed.
    ///   - errors: Array of error messages.
    ///   - validationErrors: Array of MCPValidationError for detailed error reporting.
    public init(isValid: Bool, errors: [String], validationErrors: [MCPValidationError]) {
        self.isValid = isValid
        self.errors = errors
        self.validationErrors = validationErrors
    }
}


/// Provides static methods for validating arguments against an expected schema definition.
/// Supports basic types, objects, arrays, and nested types using OpenAPI-like metadata conventions.
public class ArgumentValidator {
    /// Validates input parameters against an expected schema definition.
    /// - Parameters:
    ///   - params: The input parameters to validate, as a dictionary.
    ///   - expected: The expected schema definition, as a dictionary (OpenAPI-like convention).
    ///   - path: The current path in the parameter hierarchy (used for nested validation, default is empty).
    /// - Returns: A ValidationResult indicating if validation passed, with error messages and detailed validation errors.
    public static func validate(params: [String: Any], expected: [String: Any], path: String = "") -> ValidationResult {
        var errors: [String] = []
        var validationErrors: [MCPValidationError] = []
        for (name, typeDef) in expected {
            let fullPath = path.isEmpty ? name : "\(path).\(name)"
            guard let value = params[name] else {
                let msg = "Missing parameter '\(fullPath)'"
                errors.append(msg)
                validationErrors.append(MCPValidationError(path: fullPath, message: "Missing parameter"))
                continue
            }
            if let typeString = typeDef as? String {
                let basicErrors = validateBasicType(name: fullPath, value: value, type: typeString)
                errors.append(contentsOf: basicErrors)
                validationErrors.append(contentsOf: basicErrors.map { MCPValidationError(path: fullPath, message: $0.replacingOccurrences(of: "The parameter '\(fullPath)' ", with: "")) })
            } else if let typeDict = typeDef as? [String: Any], let type = typeDict["type"] as? String {
                switch type {
                case "string", "int", "bool":
                    let basicErrors = validateBasicType(name: fullPath, value: value, type: type)
                    errors.append(contentsOf: basicErrors)
                    validationErrors.append(contentsOf: basicErrors.map { MCPValidationError(path: fullPath, message: $0.replacingOccurrences(of: "The parameter '\(fullPath)' ", with: "")) })
                case "object":
                    guard let props = typeDict["properties"] as? [String: Any] else {
                        let msg = "The parameter '\(fullPath)' must have defined properties"
                        errors.append(msg)
                        validationErrors.append(MCPValidationError(path: fullPath, message: "Must have defined properties"))
                        break
                    }
                    guard let dictValue = value as? [String: Any] else {
                        let msg = "The parameter '\(fullPath)' must be an object/dictionary"
                        errors.append(msg)
                        validationErrors.append(MCPValidationError(path: fullPath, message: "Must be an object/dictionary"))
                        break
                    }
                    let nested = validate(params: dictValue, expected: props, path: fullPath)
                    errors.append(contentsOf: nested.errors)
                    validationErrors.append(contentsOf: nested.validationErrors)
                case "array":
                    guard let itemDef = typeDict["items"] else {
                        let msg = "The parameter '\(fullPath)' must define 'items'"
                        errors.append(msg)
                        validationErrors.append(MCPValidationError(path: fullPath, message: "Must define 'items'"))
                        break
                    }
                    guard let arr = value as? [Any] else {
                        let msg = "The parameter '\(fullPath)' must be an array"
                        errors.append(msg)
                        validationErrors.append(MCPValidationError(path: fullPath, message: "Must be an array"))
                        break
                    }
                    for (idx, elem) in arr.enumerated() {
                        if let itemTypeDict = itemDef as? [String: Any], let itemType = itemTypeDict["type"] as? String, itemType == "object" {
                            guard let elemDict = elem as? [String: Any] else {
                                let msg = "The parameter '\(fullPath)[\(idx)]' must be an object/dictionary"
                                errors.append(msg)
                                validationErrors.append(MCPValidationError(path: "\(fullPath)[\(idx)]", message: "Must be an object/dictionary"))
                                continue
                            }
                            let nested = validate(params: elemDict, expected: itemTypeDict["properties"] as? [String: Any] ?? [:], path: "\(fullPath)[\(idx)]")
                            errors.append(contentsOf: nested.errors)
                            validationErrors.append(contentsOf: nested.validationErrors)
                        } else {
                            let nested = validate(params: ["": elem], expected: ["": itemDef], path: "\(fullPath)[\(idx)]")
                            errors.append(contentsOf: nested.errors.map { $0.replacingOccurrences(of: "[\(idx)].", with: "[\(idx)]") })
                            validationErrors.append(contentsOf: nested.validationErrors.map { ve in
                                MCPValidationError(path: "\(fullPath)[\(idx)]", message: ve.message)
                            })
                        }
                    }
                default:
                    let msg = "Unsupported type for '\(fullPath)': \(type)"
                    errors.append(msg)
                    validationErrors.append(MCPValidationError(path: fullPath, message: "Unsupported type: \(type)"))
                }
            } else {
                let msg = "Invalid type definition for '\(fullPath)'"
                errors.append(msg)
                validationErrors.append(MCPValidationError(path: fullPath, message: "Invalid type definition"))
            }
        }
        return ValidationResult(isValid: errors.isEmpty, errors: errors, validationErrors: validationErrors)
    }

    /// Validates a single value against a basic type (string, int, bool).
    /// - Parameters:
    ///   - name: The name or path of the parameter.
    ///   - value: The value to validate.
    ///   - type: The expected type as a string ("string", "int", "bool").
    /// - Returns: An array of error messages if validation fails, or an empty array if validation passes.
    private static func validateBasicType(name: String, value: Any, type: String) -> [String] {
        switch type {
        case "string":
            if !(value is String) { return ["The parameter '\(name)' must be String"] }
        case "int":
            if !(value is Int) { return ["The parameter '\(name)' must be Int"] }
        case "bool":
            if !(value is Bool) { return ["The parameter '\(name)' must be Bool"] }
        default:
            return ["Unsupported basic type for '\(name)': \(type)"]
        }
        return []
    }
}

