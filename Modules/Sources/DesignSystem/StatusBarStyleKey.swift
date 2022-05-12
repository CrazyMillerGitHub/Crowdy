//
//  StatusBarStyleKey.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

import SwiftUI

// Source: - https://stackoverflow.com/questions/57063142/swiftui-status-bar-color
struct StatusBarStyleKey: PreferenceKey {
  static var defaultValue: UIStatusBarStyle = .default
  
  static func reduce(value: inout UIStatusBarStyle, nextValue: () -> UIStatusBarStyle) {
    value = nextValue()
  }
}

extension View {

  public func statusBar(style: UIStatusBarStyle) -> some View {
    preference(key: StatusBarStyleKey.self, value: style)
  }
}
