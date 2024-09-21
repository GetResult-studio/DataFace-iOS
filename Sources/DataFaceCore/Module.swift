// Created by Aleksei Smirnov on 09/21/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import UIKit

public final class Module<I: Any, O: Any> {

  // MARK: Lifecycle

  public init(viewController: UIViewController, input: I?, output: O?) {
    self.viewController = viewController
    self.input = input
    self.output = output
  }

  // MARK: Public

  public let input: I?
  public let output: O?
  public let viewController: UIViewController

}
