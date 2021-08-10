//
//  StackNavigationView.swift
//  Neptune
//
//  Created by Ethan Lipnik on 6/24/21.
//

import SwiftUI

public struct StackNavigationView<Content: View>: View {
    let content: Content
    
    @State private(set) var items: [StackContentItem<AnyView>]
    
    public init(@ViewBuilder content: @escaping () -> Content, items: [StackContentItem<AnyView>] = []) {
        self.content = content()
        
        self._items = .init(initialValue: items)
    }
    
    public var body: some View {
        ZStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .disabled(!items.isEmpty)
                .zIndex(-1)
            ForEach(items) { item in // using items.suffix(2) might improve performance
                item
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .transition(.move(edge: .trailing))
                    .disabled(item != items.last)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.stackNavigationControls, StackNavigationControls(items: $items))
    }
}

struct StackNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        StackNavigationView() {
            StackNavigationLink {
                Text("Hey")
            } label: {
                Text("Go to next item")
            }
        }
    }
}
