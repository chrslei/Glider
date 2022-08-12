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
    @Binding var filter: Period
    
    var body: some View {
     
        VStack{
            Section{
            DatePicker("Start", selection: $record.start)
                .padding(.horizontal)
                .padding(.leading)
                .font(.bold(.body)())
                .foregroundColor(.gray)
                
            DatePicker("Ende", selection: $record.end, //, displayedComponents: .hourAndMinute
                           in: record.start.addingTimeInterval(60)...record.start.addingTimeInterval(86400)
                )
                .padding(.horizontal)
                .padding(.leading)
                .font(.bold(.body)())
                .foregroundColor(.gray)
                
                Button {
                    if record.start.distance(to: record.end) > 86500 {
                        record.end = record.start.addingTimeInterval(60)
                    }
                    if record.start.distance(to: record.end) < 0 {
                        record.end = record.start.addingTimeInterval(60)
                    }
                    recordData.add(record)
                
                    //Change filter according to new record
                    if filter == .today && !record.isToday && !record.isThisMonth
                    {
                        filter = .all
                    }
                    if filter == .today && !record.isToday && record.isThisMonth
                    {
                        filter = .thisMonth
                    }
                    if filter == .thisWeek && !record.isThisWeek && !record.isToday && record.isThisMonth
                    {
                        filter = .thisMonth
                    }
                    if filter == .thisWeek && !record.isThisWeek && !record.isToday && !record.isThisMonth
                    {
                        filter = .all
                    }
                    if filter == .thisMonth && !record.isThisMonth
                    {
                        filter = .all
                    }
                    
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
            RecordCreator(record: Record(), filter: .constant(.all))
                .environmentObject(RecordData())
        }
    }
}
