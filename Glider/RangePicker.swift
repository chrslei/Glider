//
//  RangerPickerView.swift
//  Glider
//
//  Created by Christopher Leibiger on 19.08.22.
//

import SwiftUI

struct RangePicker: View {
    
    @Binding var filter : Period
    
    var body: some View {
        
        Picker(selection: $filter, label: Text("Zeitraum")) {
            Text("Alle").tag(Period.all)
            Text("Heute").tag(Period.today)
            Text("Woche").tag(Period.thisWeek)
            Text("Monat").tag(Period.thisMonth)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct RangePicker_Previews: PreviewProvider {
    static var previews: some View {
        RangePicker(filter: .constant(.all))
    }
}
