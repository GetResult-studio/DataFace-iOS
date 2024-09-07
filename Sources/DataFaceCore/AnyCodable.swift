// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Foundation

/// A type-erased `Codable` value, which can represent any valid `Codable` type such as
/// `String`, `Int`, `Double`, `Bool`, arrays, and dictionaries. This struct allows for
/// decoding and encoding of heterogeneously-typed JSON values.
public struct AnyCodable: Codable {

  // MARK: Lifecycle

  /// Decodes a value from the given decoder, attempting to handle various data types.
  /// Supports decoding values of types `String`, `Int`, `Double`, `Bool`, `[String: AnyCodable]`, and `[AnyCodable]`.
  ///
  /// - Parameter decoder: The decoder from which to decode the value.
  /// - Throws: A `DecodingError` if the value is of an unsupported type or if decoding fails.
  public init(from decoder: Decoder) throws {
    if let container = try? decoder.singleValueContainer() {
      if let value = try? container.decode(String.self) {
        self.value = value
      } else if let value = try? container.decode(Int.self) {
        self.value = value
      } else if let value = try? container.decode(Double.self) {
        self.value = value
      } else if let value = try? container.decode(Bool.self) {
        self.value = value
      } else if let value = try? container.decode([String: AnyCodable].self) {
        self.value = value
      } else if let value = try? container.decode([AnyCodable].self) {
        self.value = value
      } else {
        throw DecodingError.dataCorruptedError(
          in: container,
          debugDescription: "Unsupported JSON value")
      }
    } else {
      throw DecodingError.dataCorruptedError(
        in: try decoder.singleValueContainer(),
        debugDescription: "Unsupported JSON format")
    }
  }

  // MARK: Public

  /// Encodes the value to the given encoder, handling various data types.
  ///
  /// - Parameter encoder: The encoder to which the value will be encoded.
  /// - Throws: An `EncodingError` if the value is of an unsupported type or if encoding fails.
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()

    if let value = value as? String {
      try container.encode(value)
    } else if let value = value as? Int {
      try container.encode(value)
    } else if let value = value as? Double {
      try container.encode(value)
    } else if let value = value as? Bool {
      try container.encode(value)
    } else if let value = value as? [String: AnyCodable] {
      try container.encode(value)
    } else if let value = value as? [AnyCodable] {
      try container.encode(value)
    } else {
      throw EncodingError.invalidValue(
        value,
        EncodingError.Context(
          codingPath: encoder.codingPath,
          debugDescription: "Unsupported value"))
    }
  }

  // MARK: Internal

  /// The underlying value stored in the `AnyCodable` type, which can be any `Codable` type.
  let value: Any
}
