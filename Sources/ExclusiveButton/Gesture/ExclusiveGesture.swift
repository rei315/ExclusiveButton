//
//  ExclusiveGesture.swift
//  ExclusiveButton
//
//  Created by MINGUK KIM on 2025/03/04.
//

import UIKit

package class ExclusiveGesture: UIGestureRecognizer {
  private var isTouchingContinuously = false
  private let hostingView: UIView
  private let tapHandler: () -> Void

  package init(
    target: Any?,
    hostingView: UIView,
    tapHandler: @escaping () -> Void
  ) {
    self.hostingView = hostingView
    self.tapHandler = tapHandler
    super.init(target: target, action: nil)
  }

  package override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    isTouchingContinuously = true
    highlightIfNeeded(touches)
    state = .began
  }

  package override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard !isTouchingInView(touches) else {
      state = .changed
      return
    }
    isTouchingContinuously = false
    animateToDefaultState()
    state = .cancelled
  }

  package override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    defer {
      isTouchingContinuously = false
      state = .ended
    }
    guard isTouchingContinuously else {
      return
    }
    fireIfAvailable(touches)
  }

  package override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    isTouchingContinuously = false
    animateToDefaultState()
    state = .cancelled
  }

  private func highlightIfNeeded(_ touches: Set<UITouch>) {
    guard isTouchingInView(touches) else {
      return
    }
    animateToActiveState()
  }

  private func fireIfAvailable(_ touches: Set<UITouch>) {
    animateToDefaultState()
    guard isTouchingInView(touches) else {
      return
    }
    tapHandler()
  }

  private func isTouchingInView(_ touches: Set<UITouch>) -> Bool {
    guard let location = touches.first?.location(in: view) else {
      return false
    }
    return view?.bounds.contains(location) ?? false
  }

  private func animateToDefaultState() {
    guard let view else {
      return
    }
    ExclusiveButtonAppearance.appearance.touchUpAnimation(view, hostingView)
  }

  private func animateToActiveState() {
    guard let view else {
      return
    }
    ExclusiveButtonAppearance.appearance.touchDown(view, hostingView)
  }
}
