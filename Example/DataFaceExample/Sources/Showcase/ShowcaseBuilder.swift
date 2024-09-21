// Created by Aleksei Smirnov on 09/20/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceUI
import UIKit

final class ShowcaseBuilder {

  // MARK: Internal

  func build(json: String) -> UIViewController {
    let interactor = ShowcaseInteractor()
    customItemsFactory.delegate = interactor

    let module = DFHostBuilder(
      customItemsFactory: customItemsFactory).build(
      with: .init(content: .init(mode: .static(json: json))),
      output: interactor)

    interactor.inputDelegate = module.input

    return module.viewController
  }

  // MARK: Private

  private lazy var customItemsFactory = CustomItemsFactory()

}
