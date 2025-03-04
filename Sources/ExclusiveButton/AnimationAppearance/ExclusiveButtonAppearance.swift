//
//  ExclusiveButtonAppearance.swift
//  ExclusiveButton
//
//  Created by MINGUK KIM on 2025/03/04.
//

import UIKit

public struct ExclusiveButtonAppearance {
  public struct ExclusiveAppearance {
    public var touchDown: @MainActor @Sendable (_ wrapperView: UIView, _ hostingView: UIView) -> Void
    public var touchUpAnimation: @MainActor @Sendable (_ wrapperView: UIView, _ hostingView: UIView) -> Void
  }
  
  @MainActor public static var appearance: ExclusiveAppearance = ExclusiveAppearance(
    touchDown: { wrapperView, _ in
      UIView.animate(withDuration: 0.01, delay: 0, options: .curveEaseOut) {
        wrapperView.alpha = 0.2
      }
    },
    touchUpAnimation: { wrapperView, _ in
      UIView.animate(withDuration: 0.01, delay: 0, options: .curveEaseOut) {
        wrapperView.alpha = 1.0
      }
    }
  )
}
