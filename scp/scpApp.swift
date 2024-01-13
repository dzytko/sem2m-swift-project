//
//  scpApp.swift
//  scp
//
//  Created by a on 31/12/2023.
//

import SwiftUI

@main
struct scpApp: App {
    @StateObject private var viewModel = GameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
