// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

protocol DFHostInteractorProtocol: AnyObject {
  func viewDidLoad()
  func performActionsIfPossible(sectionDataID: AnyHashable, itemDataID: AnyHashable, _ actions: [Action])
}
