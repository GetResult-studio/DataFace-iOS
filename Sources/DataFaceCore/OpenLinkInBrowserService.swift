// Created by Aleksei Smirnov on 09/20/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCore
import UIKit

public class OpenLinkInBrowserService {

  // MARK: Lifecycle

  init() { }

  // MARK: Public

  public static let shared = OpenLinkInBrowserService()

  public func openLink(url: URL) {
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url)
    } else {
      EpoxyLogger.shared.assertionFailure(
        "UIApplication.shared can't open url = \(url.absoluteString)")
    }
  }
}
