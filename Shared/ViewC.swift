//
//  ViewC.swift
//  SwiftUI-RouterDemo
//
//  Created by 史 翔新 on 2021/05/17.
//

import SwiftUI

enum ViewCRoute {
    case back
}

protocol ViewCRouterDelegate: AnyObject {
    func viewNeedsRoute(to route: ViewCRoute)
}

struct ViewC<Router: ViewCRouterDelegate>: View {
    
    weak var router: Router?
    
    var body: some View {
        
        Button(action: {
            router?.viewNeedsRoute(to: .back)
        }, label: {
            Text("Tap me to go back")
        })
        
    }
    
}
