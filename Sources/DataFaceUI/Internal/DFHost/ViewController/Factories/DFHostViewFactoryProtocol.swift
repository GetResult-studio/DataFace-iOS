// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView

// MARK: - DFHostViewFactoryProtocol

protocol DFHostViewFactoryProtocol: AnyObject {

  func makeItem(from item: DFHostViewModel.Item?) -> (any ItemModeling)?

  func makeSupplementaryViewHeaderFooter(
    from headerFooter: DFHostViewModel.Section.HeaderFooter?)
    -> [SupplementaryItemModeling]?

  func makeSupplementaryViewBackground(
    from background: DFHostViewModel.Section.Background?)
    -> [SupplementaryItemModeling]?
}
