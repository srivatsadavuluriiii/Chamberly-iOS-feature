//
//  task_1App.swift
//  task 1
//
//  Created by thrxmbxne on 16/01/24.
//
//

import SwiftUI

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MessageFieldViewModel())
        }
    }
}
