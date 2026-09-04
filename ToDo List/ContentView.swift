//
//  ContentView.swift
//  ToDo List
//
//  Created by Akshat Tiwari on 02/09/26.
//

import SwiftUI

struct item {
    var name: String
    var completed: Bool
    var important: Bool
}

struct ContentView: View {
    @State var task = ""
    @State var allTasks: [String: [item]] = ["My Tasks": []]
    @State var lists: [String] = ["My Tasks"]
    @State var currentList: String = "My Tasks"
    @State var indx: Int?
    @AppStorage("themeColor") private var themeColor: ThemeColor = .yellow
    @AppStorage("darkMode") private var darkMode: Bool = false
    @State private var showListsSheet = false

    var body: some View {

        NavigationStack {

            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("To Do List")
                        .font(.custom("MarkerFelt-Wide", size: 35))
                        .fontWeight(.heavy)
                        .foregroundStyle(themeColor.color)

                    Spacer()

                    NavigationLink {
                        settingsView()
                    } label: {
                        Image(systemName: "gear")
                            .font(.title2)
                            .foregroundStyle(themeColor.color)
                    }
                }

                Text("~\(currentList)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            .padding(.top, 10)

            HStack {
                TextField("Enter New Task", text: $task)
                    .frame(width: 300, height: 30)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .foregroundStyle(.gray)
                    .clipShape(.rect(cornerRadius: 23))

                Button {
                    addTask()
                } label: {
                    Text("+")
                        .font(.title2)
                        .padding(18)
                        .background(themeColor.color)
                        .foregroundStyle(.white)
                        .clipShape(.circle)
                }
            }
            List {
                if let currentTasks = allTasks[currentList] {
                    ForEach(currentTasks.indices, id: \.self) { index in
                        HStack {
                            Button {
                                allTasks[currentList]?[index].completed.toggle()
                            } label: {
                                if allTasks[currentList]?[index].completed
                                    == true
                                {
                                    Image(systemName: "checkmark.circle.fill")
                                } else {
                                    Image(systemName: "circle")
                                }
                            }
                            Text(allTasks[currentList]?[index].name ?? "")
                            Spacer()
                            if allTasks[currentList]?[index].important == true {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                allTasks[currentList]?[index].important.toggle()
                            } label: {
                                if allTasks[currentList]?[index].important
                                    == true
                                {
                                    Image(systemName: "star.slash")
                                } else {
                                    Image(systemName: "star")
                                }
                            }
                            .tint(
                                allTasks[currentList]?[index].important == true
                                    ? .gray : .yellow
                            )
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                indx = index
                                removeTask()
                            } label: {
                                Image(systemName: "trash")
                            }.tint(.red)
                        }
                    }
                }
            }
            .listStyle(.plain)

            Button(action: {
                showListsSheet = true
            }) {
                Image(systemName: "list.bullet.clipboard")
                    .font(.title)
                    .foregroundStyle(themeColor.color)
                    .padding()
            }
            .sheet(isPresented: $showListsSheet) {
                listsView(
                    lists: $lists,
                    currentList: $currentList,
                    allTasks: $allTasks
                )
            }
        }
        .preferredColorScheme(darkMode ? .dark : .light)
    }

    func addTask() {
        if !task.isEmpty {
            allTasks[currentList]?.append(
                item(name: task, completed: false, important: false)
            )
            task = ""
        }
    }

    func removeTask() {
        if let indx {
            allTasks[currentList]?.remove(at: indx)
        }
        indx = nil
    }
}

#Preview {
    ContentView()
}
