// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import UIKit

// MARK: - DFHostOutputDelegete

public protocol DFHostOutputDelegete: AnyObject {
  func viewDidLoad()
  func startLoadingData()

  func didRequestToPerformAction(
    sectionDataID: AnyHashable,
    itemDataID: AnyHashable,
    _ action: Action)
}

// MARK: - DFDFHostInputDelegate

public protocol DFDFHostInputDelegate: AnyObject {
  func applyChanges(in sectionDataID: AnyHashable, with changes: Change<DFHostViewModel.Item>)
}

// MARK: - DFHostBuilderProtocol

public protocol DFHostBuilderProtocol: AnyObject {

  func build(with input: DFHostInput, output: DFHostOutputDelegete) -> Module<DFDFHostInputDelegate, DFHostOutputDelegete>
}

// MARK: - DFHostBuilder

public final class DFHostBuilder {

  // MARK: Lifecycle

  public init(customItemsFactory: CustomItemsFactoryProtocol? = nil) {
    self.customItemsFactory = customItemsFactory
  }

  // MARK: Private

  private let customItemsFactory: CustomItemsFactoryProtocol?
}

// MARK: DFHostBuilderProtocol

extension DFHostBuilder: DFHostBuilderProtocol {
  public func build(
    with input: DFHostInput,
    output: any DFHostOutputDelegete)
    -> Module<DFDFHostInputDelegate, DFHostOutputDelegete>
  {
    let viewFactory = DFHostViewFactory(customItemsFactory: customItemsFactory)
    let viewController = DFHostViewController(viewFactory: viewFactory)

    let router = DFHostRouter(viewController: viewController)

    let presenter = DFHostPresenter(viewController: viewController)
    let interactor = DFHostInteractor(input: input, router: router, presenter: presenter)

    interactor.output = output
    router.interactor = interactor
    viewController.interactor = interactor

    return .init(viewController: viewController, input: interactor, output: output)
  }
}
