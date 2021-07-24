//
//  SearchBlob.swift
//  SearchBlob
//
//  Created by Ethan Lipnik on 7/24/21.
//

import SwiftUI
import Introspect

public struct SearchBlob: View {
    @Binding public var isSearching: Bool
    @Binding public var search: String
    
    @Namespace private var nspace
    
    public init(isSearching: Binding<Bool>, search: Binding<String>) {
        self._isSearching = isSearching
        self._search = search
    }
    
    public var body: some View {
        Group {
            if isSearching {
                HStack {
                    TextField("Search", text: $search)
                        .textFieldStyle(.plain)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .introspectTextField { textField in
                            textField.becomeFirstResponder()
                        }
                    Button("Cancel") {
                        withAnimation(.spring()) {
                            isSearching.toggle()
                        }
                        
                        search = ""
                    }
#if os(iOS)
                .hoverEffect()
#endif
                }
                .padding(.horizontal)
                .background(RoundedBlob(cornerRadius: 30))
                .matchedGeometryEffect(id: "searchBar", in: nspace)
                .frame(maxWidth: 400)
            } else {
                Button {
                    withAnimation(.spring()) {
                        isSearching.toggle()
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                }
                .padding()
#if os(iOS)
                .contentShape(Circle())
                .hoverEffect()
#endif
                .background(CircleBlob())
                .matchedGeometryEffect(id: "searchBar", in: nspace)
            }
        }
    }
}

fileprivate struct SearchBlobPreview: View {
    @State var isSearching: Bool = false
    @State var search: String = ""
    
    var body: some View {
        HStack {
            if !isSearching {
                ButtonBlob(systemImage: "square.and.arrow.up") { }
            }
            SearchBlob(isSearching: $isSearching, search: $search)
        }
    }
}

struct SearchBlob_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.green], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            SearchBlobPreview()
                .shadow(radius: 30, y: 20)
                .padding(60)
        }
    }
}
