// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import UIKit

// MARK: - DFHostOutputDelegete

public protocol DFHostOutputDelegete: AnyObject { }

// MARK: - DFHostBuilderProtocol

public protocol DFHostBuilderProtocol: AnyObject {

  func build(with input: DFHostInput, output: DFHostOutputDelegete) -> UIViewController
}

// MARK: - DFHostBuilder

public final class DFHostBuilder {

  // MARK: Lifecycle

  public init(listItemsFactory: ListItemsFactoryProtocol? = nil) {
    self.listItemsFactory = listItemsFactory
  }

  // MARK: Private

  private let listItemsFactory: ListItemsFactoryProtocol?
}

// MARK: DFHostBuilderProtocol

extension DFHostBuilder: DFHostBuilderProtocol {
  public func build(
    with input: DFHostInput,
    output _: any DFHostOutputDelegete)
    -> UIViewController
  {
    let viewController = DFHostViewController()
    viewController.listItemsFactory = listItemsFactory

    let router = DFHostRouter(viewController: viewController)

    let presenter = DFHostPresenter(viewController: viewController)
    let interactor = DFHostInteractor(input: input, router: router, presenter: presenter)

    router.interactor = interactor
    viewController.interactor = interactor

    return viewController
  }
}
