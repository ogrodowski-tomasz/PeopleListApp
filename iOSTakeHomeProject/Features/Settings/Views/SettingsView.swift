//
//  SettingsView.swift
//  iOSTakeHomeProject
//
//  Created by Tomasz Ogrodowski on 22/09/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaulKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                haptics
            }
            .navigationTitle("Settings")
        }
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
