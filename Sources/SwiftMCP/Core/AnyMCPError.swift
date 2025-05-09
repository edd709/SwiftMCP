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

/// A type-erased wrapper for errors conforming to `MCPErrorProtocol`.
///
/// `AnyMCPError` allows you to store and handle any error that implements `MCPErrorProtocol` in a uniform way,
/// regardless of its concrete type. This is useful for APIs or error handling flows that need to work with heterogeneous error types.
public struct AnyMCPError: Error {
    /// The underlying error instance, type-erased to `MCPErrorProtocol`.
    private let error: MCPErrorProtocol
    
    /// Initializes a new `AnyMCPError` by wrapping an error conforming to `MCPErrorProtocol`.
    /// - Parameter error: The error to wrap.
    public init(_ error: MCPErrorProtocol) {
        self.error = error
    }
    
    /// Returns the underlying error as `MCPErrorProtocol`.
    public var underlyingError: MCPErrorProtocol {
        return error
    }
    
    /// Returns the error message from the underlying error.
    public var message: String {
        return error.message
    }
}

extension AnyMCPError: CustomStringConvertible {
    /// A textual description of the error, forwarded from the underlying error.
    public var description: String {
        return error.description
    }
}

extension AnyMCPError {
    /// Attempts to cast the underlying error to the specified type.
    /// - Parameter type: The target error type.
    /// - Returns: The underlying error as the specified type, or `nil` if the cast fails.
    public func errorAs<T: MCPErrorProtocol>(_ type: T.Type) -> T? {
        return error as? T
    }
    
    /// Checks if the underlying error is of the specified type.
    /// - Parameter type: The target error type.
    /// - Returns: `true` if the underlying error is of the specified type; otherwise, `false`.
    public func isType<T: MCPErrorProtocol>(_ type: T.Type) -> Bool {
        return error is T
    }
}

