//
//  RecordData.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI

class RecordData: ObservableObject {

    @Published private(set) var records: [Record] = [
        Record(
            start: Date.now,
            end: Date.now.addingTimeInterval(10000),
            note: "Test"
        ),
        Record(
            start: Date.now,
            end: Date.now.addingTimeInterval(1000),
            note: "Test2"
        ),
        Record(
            start: Date.now,
            end: Date.now.addingTimeInterval(80000),
            note: "Test3"
        )
    ]
    
    let saveKey = "SavedData"
    
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Record].self, from: data) {
                records = decoded
                return
            }
        }
        //no saved data!
        records = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(records) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    //add record to array
    func add(_ record: Record) {
        records.append(record)
        save()
    }
    
    func total (argument: Period) -> String{
        var totalSeconds = 0
        if argument == .all {
     totalSeconds =  Int(records
                       .map( {$0.durationInSeconds })
                       .reduce(0, +))
        }
        
        if argument == .today {
           totalSeconds = Int(records
                           .filter( {$0.isToday == true} )
                           .map( {$0.durationInSeconds })
                                               .reduce(0, +))
        }
        if argument == .thisWeek{
           totalSeconds = Int(records
                           .filter( {$0.isThisWeek == true} )
                           .map( {$0.durationInSeconds })
                                               .reduce(0, +))
        }
        if argument == .thisMonth {
           totalSeconds = Int(records
                           .filter( {$0.isThisMonth == true} )
                           .map( {$0.durationInSeconds })
                                               .reduce(0, +))
        }
        
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional

        let formattedString = formatter.string(from: TimeInterval(totalSeconds))!
        
        if formattedString.contains(":")
        {
            return(formattedString)}
        else {return (formattedString + "'")}
        
        
        
    }
    
    //delete single record from array
    func delete(_ record: Record) {
        records.removeAll { $0.id == record.id }
        save()
    }
    
    //delete multiple records from array
    func deleteMultiple(_ period: Period) {
        records.removeAll { switch period {
        case .all:
            return true
        case .today:
            return $0.isToday
        case .thisWeek:
            return $0.isThisWeek
        case .thisMonth:
            return $0.isThisMonth
        } }
        save()
    }
    
    func sortedRecords(period: Period, isFalling: Bool) -> Binding<[Record]> {
        Binding<[Record]> (
            get: {
                self.records
                    .filter {
                    switch period {
                    case .all:
                        return true
                    case .today:
                        return $0.isToday
                    case .thisWeek:
                        return $0.isThisWeek
                    case .thisMonth:
                        return $0.isThisMonth
                    
                    }
                }
                
                .sorted {
                    if isFalling
                    {
                      return $0.start > $1.start}
                    else
                    { return $0.start < $1.start}
                }
            },
        set: { records in
                for record in records {
                    if let index = self.records.firstIndex(where: { $0.id == record.id }) {
                                    self.records[index] = record
                    }
                                }
                            }
        )
    }
    }
    
    enum Period: String, CaseIterable, Identifiable {
        case all = "Alle"
        case today = "Heute"
        case thisWeek = "Woche"
        case thisMonth = "Monat"
        
        var id: String {self.rawValue}
        var name: String {self.rawValue}
    }
    
    
    

