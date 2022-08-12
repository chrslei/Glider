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
    var body: some View {
        VStack{
            
            RecordList()
            RecordCreator(record: newRecord)
                .padding()
    
        }
        .navigationTitle("Glider")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RecordData())
    }
}
