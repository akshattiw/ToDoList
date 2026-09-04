//
//  listsView.swift
//  ToDo List
//

import SwiftUI

struct listsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("themeColor") private var themeColor: ThemeColor = .yellow

    @Binding var lists: [String]
    @Binding var currentList: String
    @Binding var allTasks: [String: [item]]

    @State private var newListName = ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("New List Name", text: $newListName)
                        .frame(width: 320, height: 28)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .foregroundStyle(.gray)
                        .clipShape(.rect(cornerRadius: 20))

                    Button(action: {
                        addList()
                    }) {
                        Image(systemName: "text.badge.plus")
                            .foregroundStyle(themeColor.color)
                            .font(.system(size: 30))
                    }
                }
                .padding()

                List {
                    ForEach(lists, id: \.self) { list in
                        Button(action: {
                            currentList = list
                            dismiss()
                        }) {
                            HStack {
                                Text(list)
                                    .foregroundStyle(
                                        currentList == list
                                            ? themeColor.color : .primary
                                    )
                                Spacer()
                                if currentList == list {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(themeColor.color)
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let listsToRemove = indexSet.map { lists[$0] }
                        lists.remove(atOffsets: indexSet)
                        for list in listsToRemove {
                            allTasks.removeValue(forKey: list)
                        }
                        if !lists.contains(currentList) {
                            if lists.isEmpty {
                                lists.append("My Tasks")
                                allTasks["My Tasks"] = []
                            }
                            currentList = lists[0]
                        }
                    }
                }
            }
            .navigationTitle("My Lists")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundStyle(themeColor.color)
                }
            }
        }
    }

    func addList() {
        if !newListName.isEmpty && !lists.contains(newListName) {
            lists.append(newListName)
            allTasks[newListName] = []
            newListName = ""
        }
    }
}

#Preview {
    listsView(
        lists: .constant(["My Tasks"]),
        currentList: .constant("My Tasks"),
        allTasks: .constant(["My Tasks": []])
    )
}
