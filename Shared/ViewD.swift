//
//  ViewD.swift
//  SwiftUI-RouterDemo
//
//  Created by 史 翔新 on 2021/05/17.
//

import SwiftUI

enum ViewDRoute {
    case root
}

protocol ViewDRouterDelegate: AnyObject {
    func viewNeedsRoute(to route: ViewDRoute)
}

struct ViewD<Router: ViewDRouterDelegate>: View {
    
    weak var router: Router?
    
    var int: Int
    
    var body: some View {
        VStack {
            Text("\(int)")
            Button(action: {
                router?.viewNeedsRoute(to: .root)
            }, label: {
                Text("Return to root")
            })
        }
    }
    
}
