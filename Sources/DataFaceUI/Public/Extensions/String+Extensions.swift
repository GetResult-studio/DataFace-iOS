// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import UIKit

extension String {

  /// Calculates the height of the string constrained by a given width and font.
  ///
  /// - Parameters:
  ///   - width: The maximum width that the string can occupy.
  ///   - font: The font used for rendering the string.
  /// - Returns: The calculated height needed to display the entire string.
  public func height(forWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect( // swiftformat:disable all
      with: constraintRect,
      options: .usesLineFragmentOrigin,
      attributes: [.font: font],
      context: nil)
    return ceil(boundingBox.height)
  }

  /// Calculates the height of the string constrained by a given width, font, and maximum number of lines.
  ///
  /// - Parameters:
  ///   - width: The maximum width that the string can occupy.
  ///   - font: The font used for rendering the string.
  ///   - numberOfLines: The maximum number of lines the string can span. If set to 0, the method returns the full height of the string.
  /// - Returns: The calculated height, constrained by the number of lines or the natural height of the string.
  public func height(forWidth width: CGFloat, font: UIFont, numberOfLines: Int) -> CGFloat {
    let result = height(forWidth: width, font: font)
    let maxHeight = font.lineHeight * CGFloat(numberOfLines)
    return numberOfLines == 0 ? result : min(result, maxHeight)
  }

  /// Calculates the width of the string for a given font.
  ///
  /// - Parameter font: The font used for rendering the string.
  /// - Returns: The calculated width required to display the string.
  public func width(usingFont font: UIFont) -> CGFloat {
    ceil(size(withAttributes: [.font: font]).width)
  }
  
  /// Calculates the size of the string constrained by the font.
  ///
  /// - Parameter font: The font used for rendering the string.
  /// - Returns: The size of the string including width and height.
  public func size(for font: UIFont) -> CGSize {
    let availableSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    let result = self.boundingRect( // swiftformat:disable all
      with: availableSize,
      options: [.usesLineFragmentOrigin],
      attributes: [.font: font],
      context: nil)
    return CGSize(width: ceil(result.width), height: ceil(result.height))
  }
}
