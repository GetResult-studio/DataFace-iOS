// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore

protocol DFHostPresenterProtocol: AnyObject {
  func didRecieveStaticJSON(_ json: String)
  func applyChanges(sectionDataID: AnyHashable, changes: Change<DFHostViewModel.Item>)
}
