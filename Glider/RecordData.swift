//
//  RecordData.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI

class RecordData: ObservableObject {
    @Published var records: [Record] = [
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
    
    }
    

