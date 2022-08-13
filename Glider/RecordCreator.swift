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
    @State var start: Date = Date()
    @State var end: Date = Date()
    
    var body: some View {
     
        VStack{
    
            Section{
                
                DatePicker(selection: Binding<Date>(
                       get: { self.start },
                       set: { self.start = $0
                           if self.end < $0 {
                               self.end = $0
                           }
                           if self.end > $0.addingTimeInterval(86400) {
                               self.end = $0
                           }
                       }), in: Date.distantPast...Date.distantFuture) {
                        Text("Start")
                    }
                           .padding(.horizontal)
                           .padding(.leading)
                           .font(.bold(.body)())
                           .foregroundColor(.gray)

                DatePicker(selection: $end, in: start...start.addingTimeInterval(86400)) {
                        Text("End")
                    }
                        .padding(.horizontal)
                        .padding(.leading)
                        .font(.bold(.body)())
                        .foregroundColor(.gray)
                    
        
                Button {
                    
                
                    recordData.add(Record(start: start, end: end))
                    
                
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
    
        
    }
    
    struct EventCreator_Previews:
        PreviewProvider {
        static var previews: some View {
            RecordCreator(record: Record(), filter: .constant(.all))
                .environmentObject(RecordData())
        }
    }
}
