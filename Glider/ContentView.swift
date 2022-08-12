//
//  ContentView.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var recordData: RecordData
    @State var newRecord = Record()
    @State var filter : Period
    var body: some View {
        VStack{
            
            RecordList(filter: $filter)
            RecordCreator(record: newRecord, filter: $filter)
                .padding()
    
        }
        .navigationTitle("Glider")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(filter: .all).environmentObject(RecordData())
    }
}
