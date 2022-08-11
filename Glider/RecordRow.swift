//
//  RecordRow.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI
import Foundation

struct RecordRow: View {
    var record : Record
    
    var body: some View {
        HStack {
            Text(record.start.formatted(date: .numeric, time: .omitted))
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
                .frame(width: 65, alignment: .leading)
            Spacer()
            Text(record.start.formatted(date: .omitted, time: .shortened) + " – " + record.end.formatted(date: .omitted, time: .shortened) )
                .frame(width: 165, alignment: .center)
            Spacer()
            Text(record.durationInMinutesAsString)
                .foregroundColor(.green)
                .bold()
                .frame(width: 60, alignment: .trailing)
            
        }
    }
}


struct RecordRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordRow(record: Record(
            start: Date.now,
            end: Date.now.addingTimeInterval(10000),
            note: "Test2"
        ))
    }
}
