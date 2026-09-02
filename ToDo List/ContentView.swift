//
//  ContentView.swift
//  ToDo List
//
//  Created by Akshat Tiwari on 02/09/26.
//

import SwiftUI

struct item{
    var name: String
    var completed: Bool
    var important: Bool
}
struct ContentView: View{
    @State var task = ""
    @State var itemList: [item] = []
    @State var indx: Int?
    var body: some View{
        
        NavigationStack{
            
            Text("To Do List")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.blue)
            HStack {
                TextField("Enter New Task", text: $task)
                    .frame(width: 300, height: 30)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .foregroundStyle(.gray)
                    .clipShape(.rect(cornerRadius: 23))
                
                
                Button(){
                    addTask()
                } label: {
                    Text("+")
                        .font(.title2)
                        .padding(18)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.circle)
                }
            }
            List{
                ForEach(itemList.indices, id: \.self){
                    index in
                    HStack{
                        Button{
                            itemList[index].completed.toggle()
                        } label: {
                            if(itemList[index].completed){
                                Image(systemName: "checkmark.circle")
                            }
                            else{
                                Image(systemName: "circle")
                            }
                        }
                        Text(itemList[index].name)
                        if(itemList[index].important){
                            Image(systemName: "star.fill")
                        }
                    }
                    .swipeActions(edge : .leading){
                        Button{
                            itemList[index].important.toggle()
                        } label: {
                            Text("Mark Important")
                        }
                    }
                    .swipeActions(edge : .trailing){
                        Button{
                            indx = index
                            removeTask()
                        } label: {
                            Text("Delete")
                        } .tint(.red)
                    }
                }
            }
            .listStyle(.plain)
            NavigationLink{
                settingsView()
            } label: {
                Image(systemName: "gear")
            }
        }
    }
    
    func addTask(){
        if(!task.isEmpty){
            itemList.append(item(name: task, completed: false, important: false))
            task = " "
        }
    }
    
    func removeTask(){
        if let indx{
            itemList.remove(at: indx)
        }
        indx = nil
    }
}






#Preview {
    ContentView()
}
