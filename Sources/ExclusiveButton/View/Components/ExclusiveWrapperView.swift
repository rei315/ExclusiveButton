//
//  ExclusiveWrapperView.swift
//  ExclusiveButton
//
//  Created by MINGUK KIM on 2025/03/04.
//

import SwiftUI

public class ExclusiveWrapperView: UIView {
  package var contentView: UIView?

  override init(frame: CGRect) {
    super.init(frame: frame)
    isExclusiveTouch = true
    isUserInteractionEnabled = true
    backgroundColor = .clear
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  package func addHostingView(_ view: UIView) {
    self.contentView = view
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: topAnchor),
      view.bottomAnchor.constraint(equalTo: bottomAnchor),
      view.leadingAnchor.constraint(equalTo: leadingAnchor),
      view.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }

  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    self.exclusiveAllTouches()
  }
}
