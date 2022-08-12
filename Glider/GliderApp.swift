//
//  GliderApp.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI

@main
struct GliderApp: App {
    @StateObject private var recordData = RecordData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(filter: .all)
            }
            .environmentObject(recordData)
        }
    }
}
