//
//  ExclusiveButtonAppearance.swift
//  ExclusiveButton
//
//  Created by MINGUK KIM on 2025/03/04.
//

import UIKit

public struct ExclusiveButtonAppearance {
  public struct ExclusiveAppearance {
    public var touchDown: @MainActor @Sendable (UIView?) -> Void
    public var touchUpAnimation: @MainActor @Sendable (UIView?) -> Void
  }
  
  @MainActor public static var appearance: ExclusiveAppearance = ExclusiveAppearance(
    touchDown: { view in
      UIView.animate(withDuration: 0.01, delay: 0, options: .curveEaseOut) {
        view?.alpha = 0.2
      }
    },
    touchUpAnimation: { view in
      UIView.animate(withDuration: 0.01, delay: 0, options: .curveEaseOut) {
        view?.alpha = 1.0
      }
    }
  )
}
