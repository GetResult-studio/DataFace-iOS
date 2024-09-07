// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Foundation

public struct DFHostInput {

  // MARK: Lifecycle

  /// Initializes a new instance of `DFHostInput` with the given content.
  ///
  /// - Parameter content: The content of the DFHostInput, which specifies the mode of content rendering.
  public init(content: Content) {
    self.content = content
  }

  // MARK: Public

  /// A nested structure representing the content of the DFHostInput.
  public struct Content {

    // MARK: Lifecycle

    /// Initializes a new instance of `Content` with a specific content mode.
    ///
    /// - Parameter mode: The mode that defines how the content should be handled, either from a URL or a static JSON string.
    public init(mode: Mode) {
      self.mode = mode
    }

    // MARK: Public

    /// An enum that defines the content mode for rendering.
    /// It can be either a backend-driven UI that loads from a URL or static content represented as a JSON string.
    public enum Mode {
      /// Represents content driven by a backend, loading from a specific URL.
      /// - Parameter url: The URL from which the content will be loaded.
      case backendDrivenUI(url: URL)

      /// Represents static content that is provided as a JSON string.
      /// - Parameter json: The static content in JSON format.
      case `static`(json: String)
    }

    /// The mode of the content, which can either be backend-driven or static.
    public let mode: Mode
  }

  /// The content associated with the DFHostInput.
  public let content: Content
}
