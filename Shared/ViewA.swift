//
//  ViewA.swift
//  SwiftUI-RouterDemo
//
//  Created by 史 翔新 on 2021/05/17.
//

import SwiftUI

enum ViewARoute {
    case b
    case c
    case z
}

protocol ViewARouter: AnyObject {
    func viewNeedsRoute(to route: ViewARoute)
}

struct ViewA<Router: ViewARouter>: View {
    
    var router: Router
    
    var body: some View {
        
        VStack {
            
            Button {
                router.viewNeedsRoute(to: .b)
            } label: {
                Text("Tap me to View B")
            }
            
            Button {
                router.viewNeedsRoute(to: .c)
            } label: {
                Text("Tap me to View C")
            }
            
            Button {
                router.viewNeedsRoute(to: .z)
            } label: {
                Text("Tap me to View Z")
            }
            
        }
        
    }
    
}
