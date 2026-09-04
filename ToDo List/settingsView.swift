//
//  settingsView.swift
//  ToDo List
//
//  Created by Akshat Tiwari on 02/09/26.
//

import SwiftUI

enum ThemeColor: String, CaseIterable, Identifiable {
    case blue, red, green, teal, yellow, brown, black

    var id: String { self.rawValue }

    var color: Color {
        switch self {
        case .blue: return .blue
        case .red: return .red
        case .green: return .green
        case .teal: return .teal
        case .yellow: return .yellow
        case .brown: return .brown
        case .black: return .black
        }
    }
}

struct settingsView: View {
    @AppStorage("themeColor") private var themeColor: ThemeColor = .yellow
    @AppStorage("darkMode") private var darkMode: Bool = false

    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]

    var body: some View {
        Form {
            Section(header: Text("Theme Color")) {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(ThemeColor.allCases) { theme in
                        Button(action: {
                            themeColor = theme
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(theme.color)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            Color.primary.opacity(0.3),
                                            lineWidth: 1
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            Color.primary,
                                            lineWidth: themeColor == theme
                                                ? 4 : 0
                                        )
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical)
            }
            Section(header: Text("Appearance")) {
                Toggle("Dark Mode", isOn: $darkMode)
            }
        }
        .navigationTitle("Settings")
        .preferredColorScheme(darkMode ? .dark : .light)
    }
}

#Preview {
    settingsView()
}
