//
//  RecordList.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI

struct RecordList: View {
    @EnvironmentObject var recordData: RecordData
    @State var filter : Period = .all
    
    // returns the proper grammatical number for String "record"
    func recordPlural() -> String {
        if recordData.sortedRecords(period: filter).count != 1 {
            return "Einträge"
        }
        else {
            return "Eintrag"
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
                if recordData.sortedRecords(
                    period: filter).count == 0 {
                    Text("Keine Einträge")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                else {
                    
                    Text("Gesamtzeit " + recordData.total(argument: filter))
                        .bold()
                    
                    
                    Section (String(recordData.sortedRecords(
                        period: filter).count) + " " + recordPlural()){
                            ForEach(recordData.sortedRecords(
                                period: filter)){ $record in
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
            RecordList().environmentObject(RecordData())
        }
    }
}
