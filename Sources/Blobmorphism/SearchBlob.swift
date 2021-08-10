//
//  SearchBlob.swift
//  SearchBlob
//
//  Created by Ethan Lipnik on 7/24/21.
//

import SwiftUI
import Introspect

public struct SearchBlob<Content: View>: View {
    @Binding public var isSearching: Bool
    @Binding public var search: String
    let content: Content?
    public let intensity: BlurIntensity
    
    @Namespace private var nspace
    
    public init(isSearching: Binding<Bool>, search: Binding<String>, intensity: BlurIntensity = .thin,content: (() -> Content)? = nil) {
        self._isSearching = isSearching
        self._search = search
        self.intensity = intensity
        self.content = content?()
    }
    
    public var body: some View {
        Group {
            if isSearching {
                VStack {
                    HStack {
                        TextField("Search", text: $search)
                            .textFieldStyle(.plain)
                            .keyboardType(.webSearch)
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
                    .background(RoundedBlob(cornerRadius: 30, intensity: intensity).shadow(color: Color("Shadow"), radius: 15, y: 10))
                    .compositingGroup()
                    .matchedGeometryEffect(id: "searchBar", in: nspace)
                    if let content = content {
                        ZStack {
                            RoundedBlob(intensity: .material)
                                .shadow(color: Color("Shadow"), radius: 15, y: 10)
                            content
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                        .compositingGroup()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .compositingGroup()
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
                .background(CircleBlob(intensity: intensity).shadow(color: Color("Shadow"), radius: 15, y: 10))
                .compositingGroup()
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
            SearchBlob(isSearching: $isSearching, search: $search) {
                Text("This is a result")
            }
        }
    }
}

struct SearchBlob_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.green], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            SearchBlobPreview()
                .padding(60)
        }
    }
}
