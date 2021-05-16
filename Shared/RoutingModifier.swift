//
//  RoutingModifier.swift
//  SwiftUI-RouterDemo
//
//  Created by 史 翔新 on 2021/05/17.
//

import SwiftUI

protocol RouterObject: ObservableObject {
    
    associatedtype NextNavigationView: View
    func navigationBinding(for viewID: String) -> Binding<Bool>
    @ViewBuilder func nextNavigationView(for viewID: String) -> NextNavigationView
    
    associatedtype NextPresentationView: View
    func presentationBinding(for viewID: String) -> Binding<Bool>
    @ViewBuilder func nextPresentationView(for viewID: String) -> NextPresentationView
    
}

struct RoutingModifier<Router: RouterObject>: ViewModifier {
    
    @ObservedObject var router: Router
    var currentViewID: String
    
    func body(content: Content) -> some View {
        content
            .background(EmptyNavigationLink(destination: router.nextNavigationView(for: currentViewID), isActive: router.navigationBinding(for: currentViewID)))
            .fullScreenCover(isPresented: router.presentationBinding(for: currentViewID), content: { router.nextPresentationView(for: currentViewID) })
    }
    
}

private struct EmptyNavigationLink<Destination: View>: View {
    
    var destination: Destination
    var isActive: Binding<Bool>
    
    var body: some View {
        NavigationLink(
            destination: destination, isActive: isActive, label: { EmptyView() })
    }
    
}

extension View {
    
    func injectRouter<Router: RouterObject>(_ router: Router, with viewID: String) -> some View {
        modifier(RoutingModifier(router: router, currentViewID: viewID))
    }
    
}
