// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Foundation

/// Extension of `KeyedDecodingContainer` to provide the ability to decode a nested container as `Data`.
extension KeyedDecodingContainer {

  /// Decodes a nested container represented as `[String: AnyCodable]` and serializes it into `Data` if present.
  /// This is useful when the nested JSON is expected to be encoded as `Data`.
  ///
  /// - Parameter key: The key used to decode the nested container.
  /// - Returns: The serialized `Data` of the nested container if it exists, or `nil` if not present.
  /// - Throws: An error if the decoding or serialization fails.
  public func decodeNestedContainerAsDataIfPresent(forKey key: Key) throws -> Data? {
    if let nestedContainer = try decodeIfPresent([String: AnyCodable].self, forKey: key) {
      let jsonData = try JSONSerialization.data(
        withJSONObject: nestedContainer.mapValues { $0.value },
        options: [])
      return jsonData
    }

    return nil
  }
}
