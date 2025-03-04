//
//  ExclusiveButton.swift
//  ExclusiveButton
//
//  Created by MINGUK KIM on 2025/03/04.
//

import SwiftUI
import UIKit

public struct ExclusiveButton<Content: View>: UIViewRepresentable {
  private var action: () -> Void
  private var label: () -> Content

  public init(
    action: @escaping () -> Void,
    @ViewBuilder label: @escaping () -> Content
  ) {
    self.action = action
    self.label = label
  }

  public func makeUIView(context: Context) -> ExclusiveWrapperView {
    let hostingController = UIHostingController(rootView: label())
    let wrapperView: ExclusiveWrapperView = .init()
    let hostingView: UIView = hostingController.view
    wrapperView.addHostingView(hostingView)
    let gesture = ExclusiveGesture(
      target: context.coordinator,
      hostingView: hostingView,
      tapHandler: context.coordinator.action
    )
    gesture.delegate = context.coordinator
    wrapperView.addGestureRecognizer(gesture)
    return wrapperView
  }

  public func sizeThatFits(_ proposal: ProposedViewSize, uiView: ExclusiveWrapperView, context: Context) -> CGSize? {
    let proposalSize = proposal.replacingUnspecifiedDimensions()
    let size = uiView.contentView?.sizeThatFits(proposalSize)
    return size
  }

  public func updateUIView(_ uiView: ExclusiveWrapperView, context: Context) {}

  public func makeCoordinator() -> Coordinator {
    return Coordinator(action: action)
  }

  public class Coordinator: NSObject, UIGestureRecognizerDelegate {
    fileprivate var action: () -> Void

    fileprivate init(action: @escaping () -> Void) {
      self.action = action
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      true
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      true
    }
  }
}
