//
//  ViewB.swift
//  SwiftUI-RouterDemo
//
//  Created by 史 翔新 on 2021/05/17.
//

import SwiftUI

enum ViewBRoute {
    case d(index: Int)
}

protocol ViewBRouterDelegate: AnyObject {
    func viewNeedsRoute(to route: ViewBRoute)
}

struct ViewB<Router: ViewBRouterDelegate>: View {
    
    weak var router: Router?
    
    var body: some View {
        
        VStack {
            
            ForEach(0 ..< 10) { index in
                Button(action: {
                    router?.viewNeedsRoute(to: .d(index: index))
                }, label: {
                    Text("Tap me to View D with Index \(index)")
                })
            }
            
        }
        
    }
    
}
