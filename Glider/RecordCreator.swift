//
//  RecordCreator.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI

struct RecordCreator: View {
    @State var record: Record
    @EnvironmentObject var recordData : RecordData
    
    var body: some View {
     
        VStack{
            Section{
            DatePicker("Start", selection: $record.start)
                .padding(.horizontal)
                
                DatePicker("Ende", selection: $record.end //, displayedComponents: .hourAndMinute
                )
                .padding(.horizontal)
                Button {
                    recordData.records.append(record)
                    record = Record(start: record.start, end: record.end)
                } label: { Image (systemName: "plus")}
                    .padding(.top)
            }
        }
        .navigationTitle("Glider")
        
    }
    
    struct EventCreator_Previews:
        PreviewProvider {
        static var previews: some View {
            RecordCreator(record: Record())
                .environmentObject(RecordData())
        }
    }
}
