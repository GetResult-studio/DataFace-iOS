// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView

// MARK: - DFHostViewFactoryProtocol

protocol DFHostViewFactoryProtocol: AnyObject {

  func makeItem(from item: DFHostViewModel.Item?) -> (any ItemModeling)?

  func makeSupplementaryViewHeader(
    from header: DFHostViewModel.Section.Header?)
    -> [SupplementaryItemModeling]?

  func makeSupplementaryViewBackground(
    from background: DFHostViewModel.Section.Background?)
    -> [SupplementaryItemModeling]?
}
