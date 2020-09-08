//
//  ContentView.swift
//  ListViewApp
//
//  Created by 磯部直 on 2020/09/06.
//  Copyright © 2020 isobe.com. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    
    @ObservedObject var nList = namesList()
    
    @ObservedObject var tList = TaskList()
    
    @State var newTask : String = ""
    
    @Environment(\.editMode) var mode
    
    var addTaskBar : some View{
        HStack{
            TextField("追加してください", text: self.$newTask)
            Button(action: self.addNewTask, label: {Text("add")})
        }
    }
    


    func addNewTask() {
        tList.tasks.append(Task(id: String(tList.tasks.count + 1), taskItem: newTask))
        self.newTask = ""
    }
    
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    addTaskBar.padding()
                    List {
                        ForEach(self.tList.tasks){
                            Index in
                            Text(Index.taskItem)
                        }.onDelete(perform: rowRemove)
                    } .navigationBarTitle("Taskリスト")
                    .navigationBarItems(trailing: EditButton())
                }
            }
        }

    }
    
/// 行削除処理
   func rowRemove(offsets: IndexSet) {
    tList.tasks.remove(atOffsets: offsets)
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
