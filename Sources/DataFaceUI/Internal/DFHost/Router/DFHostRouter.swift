// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import UIKit

// MARK: - DFHostRouter

final class DFHostRouter {

  // MARK: Lifecycle

  init(viewController: UIViewController?) {
    self.viewController = viewController
  }

  // MARK: Internal

  weak var viewController: UIViewController?
  weak var interactor: DFHostInteractorProtocol?
}

// MARK: DFHostRouterProtocol

extension DFHostRouter: DFHostRouterProtocol { }
