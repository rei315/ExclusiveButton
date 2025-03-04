//
//  UIView+.swift
//  ExclusiveButton
//
//  Created by MINGUK KIM on 2025/03/04.
//

import UIKit

extension UIView {
  package func exclusiveAllTouches() {
    applyAllViews { $0.isExclusiveTouch = true }
  }

  private func applyAllViews(_ apply: @escaping (UIView) -> Void) {
    apply(self)
    applyAllSubviews(self, apply: apply)
  }

  private func applyAllSubviews(_ view: UIView, apply: @escaping (UIView) -> Void) {
    view.subviews.forEach { (view: UIView) -> Void in
      apply(view)
      applyAllSubviews(view, apply: apply)
    }
  }
}
