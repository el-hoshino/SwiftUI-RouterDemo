//
//  Router.swift
//  SwiftUI-RouterDemo
//
//  Created by 史 翔新 on 2021/05/17.
//

import SwiftUI

final class Router: ObservableObject {
    
    @Published private var viewARoute: ViewARoute?
    @Published private var viewBRoute: ViewBRoute?
    
    private func makeViewA() -> some View {
        ViewA(router: self)
            .injectRouter(self, with: "A")
    }
    
    private func makeViewB() -> some View {
        ViewB(router: self)
            .injectRouter(self, with: "B")
    }
    
    private func makeViewC() -> some View {
        ViewC(router: self)
            .injectRouter(self, with: "C")
    }
    
    private func makeViewD(int: Int) -> some View {
        ViewD(router: self, int: int)
    }
    
    private func makeViewZ() -> some View {
        ViewZ(router: self)
            .injectRouter(self, with: "Z")
    }
    
}

extension Router {
    
    func makeView() -> some View {
        NavigationView {
            makeViewA()
        }
    }
    
}

extension Router {
    
    @ViewBuilder
    private func nextViewAfterA(accordingTo route: ViewARoute?) -> some View {
        
        if let route = route {
            switch route {
            case .b:
                makeViewB()
                
            case .c:
                makeViewC()
                
            case .z:
                makeViewZ()
            }
            
        } else {
            EmptyView()
        }
        
    }
    
    @ViewBuilder
    private func nextViewAfterB(accordingTo route: ViewBRoute?) -> some View {
        
        if let route = route {
            switch route {
            case .d(let int):
                makeViewD(int: int)
            }
            
        } else {
            EmptyView()
        }
        
    }
    
}

extension Router: RouterObject {
    
    func navigationBinding(for viewID: String) -> Binding<Bool> {
        switch viewID {
        case "A":
            return .init(get: { [unowned self] in return self.viewARoute == .b || self.viewARoute == .c },
                         set: { [unowned self] in assert($0 == false); self.viewARoute = nil })
            
        case "B":
            return .init(get: { [unowned self] in return self.viewBRoute != nil },
                         set: { [unowned self] in assert($0 == false); self.viewBRoute = nil })
            
        default:
            return .constant(false)
        }
    }
    
    @ViewBuilder
    func nextNavigationView(for viewID: String) -> some View {
        switch viewID {
        case "A":
            nextViewAfterA(accordingTo: viewARoute)
            
        case "B":
            nextViewAfterB(accordingTo: viewBRoute)
            
        default:
            EmptyView()
        }
    }
    
    func presentationBinding(for viewID: String) -> Binding<Bool> {
        switch viewID {
        case "A":
            return .init(get: { [unowned self] in return self.viewARoute == .z },
                         set: { [unowned self] in assert($0 == false); self.viewARoute = nil })
            
        default:
            return .constant(false)
        }
    }
    
    func nextPresentationView(for viewID: String) -> some View {
        switch viewID {
        case "A":
            nextViewAfterA(accordingTo: viewARoute)
            
        default:
            EmptyView()
        }
    }
    
}

extension Router: ViewARouterDelegate {
    
    func viewNeedsRoute(to route: ViewARoute) {
        viewARoute = route
    }
    
}

extension Router: ViewBRouterDelegate {
    
    func viewNeedsRoute(to route: ViewBRoute) {
        viewBRoute = route
    }
    
}

extension Router: ViewCRouterDelegate {
    
    func viewNeedsRoute(to route: ViewCRoute) {
        switch route {
        case .back:
            assert(viewARoute == .c)
            viewARoute = nil
        }
    }
    
}

extension Router: ViewDRouterDelegate {
    
    func viewNeedsRoute(to route: ViewDRoute) {
        switch route {
        case .root:
            assert(viewARoute == .b)
            assert(viewBRoute?.isD ?? false)
            viewARoute = nil
        }
    }
    
}

extension Router: ViewZRouterDelegate {
    
    func viewNeedsRoute(to route: ViewZRoute) {
        switch route {
        case .done:
            assert(viewARoute == .z)
            viewARoute = nil
        }
    }
    
}

private extension ViewBRoute {
    var isD: Bool {
        switch self {
        case .d:
            return true
        }
    }
}
