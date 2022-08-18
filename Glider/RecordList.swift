//
//  RecordList.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI
import Charts

struct RecordList: View {
    @EnvironmentObject var recordData: RecordData
    @Binding var filter : Period
    @State private var showingDeleteAlert = false
    
    // returns the proper grammatical number for String "record"
    func recordPlural() -> String {
        if recordData.sortedRecords(period: filter, isFalling: true).count != 1 {
            return "Einträge"
        }
        else {
            return "Eintrag"
        }
    }
    
    func returnListTitle(_ period: Period) -> String {
        if period.name == "Heute"
        {
            return Date.now.formatted(date: .abbreviated, time: .omitted)
        }
        if period.name == "Woche"
        {
            return (Date.now.startOfWeek?.formatted(.dateTime.day().month()) ?? "Ka") + " – " + (Date.now.endOfWeek?.formatted(date: .abbreviated, time: .omitted))!
        }
        if period.name == "Monat"
        { return (Date.now.startOfMonth().formatted(.dateTime.day().month()) ) + " – " + (Date.now.endOfMonth().formatted(date: .abbreviated, time: .omitted))}
        
        else {
            
            if recordData.sortedRecords(period: filter, isFalling: true).count == 0 {
                return "Alle"
            }
            
            return  (recordData.records.min(by: {a, b in a.start < b.start})?.start.formatted(date: .abbreviated, time: .omitted) ?? "Ka") + " – " + (recordData.records.max(by: {a, b in a.start < b.start})?.start.formatted(date: .abbreviated, time: .omitted) ?? "Ka")
        }
        
    }
    
    var body: some View {
        
        
        
        VStack{
            
            
            Picker(selection: $filter, label: Text("Zeitraum")) {
                Text("Alle").tag(Period.all)
                Text("Heute").tag(Period.today)
                Text("Woche").tag(Period.thisWeek)
                Text("Monat").tag(Period.thisMonth)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            
            List{
                
                
                Section(returnListTitle(filter)){
                    
                    if recordData.sortedRecords(
                        period: filter, isFalling: true).count == 0 {
                        
                        
                        Text("Keine Einträge")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        HStack {
                            Image(systemName: "calendar.badge.plus")
                                .foregroundColor(.gray)
                            Text("Auf + tippen, um einen neuen Eintrag zu erstellen")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.gray)
                                .padding(.leading, +10)
                        }
                        .padding()
                    }
                    else {
                        
                        //ChartView
                        
                        
                        VStack{
                            if #available(iOS 16.0, *) //, recordData.sortedRecords(
                            //  period: filter, isFalling: true).count > 1
                            {
                                
                                Chart {
                                    
                                    ForEach(recordData.sortedRecords(
                                        period: filter, isFalling: false)) { $record in
                                            LineMark(
                                                x: .value("Shape Type", record.start.formatted(.dateTime.day().month())),
                                                y: .value("Total Count", record.durationInHours)
                                            )
                                        }
                                }
                                .frame(height: 100)
                                .padding()
                                
                            } else {
                                // Fallback on earlier versions
                            }
                            
                            
                            HStack{
                                
                                
                                Button(recordData.total(argument: filter) +  " Gesamt", action: {})
                                    .buttonStyle(.bordered)
                                    .disabled(true)
                                
                                Menu(String(recordData.sortedRecords(
                                    period: filter, isFalling: true).count) + " " + recordPlural()) {
                                        Button(role: .destructive, action: {showingDeleteAlert = true }) {
                                            Label("Alle löschen", systemImage: "trash")
                                        }
                                    }
                                    .confirmationDialog(
                                        Text(String(recordData.sortedRecords(period: filter, isFalling: true).count) + " " + recordPlural() + " löschen?"),
                                        isPresented: $showingDeleteAlert,
                                        titleVisibility: .visible
                                    ) {
                                        Button("Löschen", role: .destructive) {
                                            withAnimation {
                                                recordData.deleteMultiple(filter)
                                            }
                                        }
                                    }
                                    .buttonStyle(.bordered)
                                
                                
                            }
                            
                        }}
                }
                .headerProminence(.increased)
                
                //Einträge
                if recordData.sortedRecords(
                    period: filter, isFalling: true).count > 0
                    
                {
                    Section (recordPlural()){
                        ForEach(recordData.sortedRecords(
                            period: filter, isFalling: true)){ $record in
                                RecordRow(record: record)
                                    .swipeActions(allowsFullSwipe: false) {
                                        Button(role: .destructive) {
                                            recordData.delete(record)
                                        } label: {
                                            Label("Delete", systemImage: "trash.fill")
                                        }
                                    }
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
            RecordList(filter: .constant(.all)).environmentObject(RecordData())
        }
    }
}


extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
