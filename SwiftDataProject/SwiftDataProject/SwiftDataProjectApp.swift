//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Christopher Endress on 7/16/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
