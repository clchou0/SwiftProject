//
//  ViewController.swift
//  Project
//
//  Created by CLChou on 2026/5/3.
//

import Foundation

enum Route: Hashable {
    case home
    case tables(UUID)
    case order(UUID)      // sessionID
    case checkout
}

class ViewController {
    // Documents route of the app flow (except for home)
    var routes: Set<Route> = [];
}
