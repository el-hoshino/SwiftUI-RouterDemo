//
//  ViewZ.swift
//  SwiftUI-RouterDemo
//
//  Created by 史 翔新 on 2021/05/17.
//

import SwiftUI

import SwiftUI

enum ViewZRoute {
    case done
}

protocol ViewZRouter: AnyObject {
    func viewNeedsRoute(to route: ViewZRoute)
}

struct ViewZ<Router: ViewZRouter>: View {
    
    var router: Router
    
    var body: some View {
        
        Button(action: {
            router.viewNeedsRoute(to: .done)
        }, label: {
            Text("Done")
        })
        
    }
    
}
