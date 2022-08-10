//
//  RecordList.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI

struct RecordList: View {
    @EnvironmentObject var recordData: RecordData
    var body: some View {
        
        
        List {
            Section(header:Text("GESAMT " +
                        
                                String(recordData.records
                .filter( {$0.isToday == true} ) // Step 1
                .map( {$0.duration }) // Step 2
                                    .reduce(0, +))
                            ))
            {ForEach(recordData.records){ record in
                RecordRow(record: record)
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            print("Muting conversation")
                        } label: {
                            Label("Mute", systemImage: "bell.slash.fill")
                        }
                        .tint(.indigo)
                        
                        Button(role: .destructive) {
                            print("Deleting conversation")
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
        }
        }
    }
}

struct RecordList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RecordList().environmentObject(RecordData())
        }
    }
}
