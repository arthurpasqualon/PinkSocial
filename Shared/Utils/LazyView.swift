//
//  LazyView.swift
//  PinkSocial
//
//  Created by Arthur Pasqualon on 23/10/21.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content{
        build()
    }
    
}
