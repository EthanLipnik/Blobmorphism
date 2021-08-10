//
//  StackNavigation.swift
//  StackNavigation
//
//  Created by Ethan Lipnik on 8/5/21.
//

import SwiftUI

public struct StackNavigationControls {
    @Binding public var items: [StackContentItem<AnyView>]
    
    public func push(_ view: StackContentItem<AnyView>) {
        withAnimation(.spring()) {
            items.append(view)
        }
    }
    
    public func pop() {
        if !items.isEmpty {
            items.removeLast()
        }
    }
}

private struct StackNavigationControlsrKey: EnvironmentKey {
    static let defaultValue = StackNavigationControls(items: .constant([]))
}

extension EnvironmentValues {
    public var stackNavigationControls: StackNavigationControls {
        get { self[StackNavigationControlsrKey.self] }
        set { self[StackNavigationControlsrKey.self] = newValue }
    }
}
