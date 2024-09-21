// Created by Aleksei Smirnov on 09/20/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Foundation

public struct Action: Decodable {

  // MARK: Lifecycle

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decode(`Type`.self, forKey: .type)
    url = try container.decode(URL.self, forKey: .url)
  }

  // MARK: Public

  public enum `Type`: String, Decodable {
    case didSelect
    case willDisplay
    case didEndDisplaying
  }

  public let type: `Type`
  public let url: URL

  // MARK: Private

  private enum CodingKeys: String, CodingKey {
    case type, url
  }

}
