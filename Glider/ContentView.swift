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
    @State var info = false
    
    var body: some View {
        
        VStack{
            HStack {
                Text("Glider")
                    .font(.largeTitle.bold())
                
                Spacer()
                
                Button {
                    info = true
                }
                label : {
                    Image(systemName: "info.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $info)
                {
                    NavigationView {
                        InfoView()
                            .navigationBarTitle(Text("Info"))
                            .toolbar {
                                      ToolbarItem() {
                                          Button {
                                              info = false
                                          }
                                      label: {
                                          Image(systemName: "xmark")
                                              .padding([.top], 20)
                                      }
                                      
                    }
                }
                    }
                }
    
            }
            .padding(.all)
            .padding(.bottom, -15)
            .padding(.top, +10)
            .navigationBarHidden(true)
            
            
            RecordList(filter: $filter)
            RecordCreator(record: newRecord, filter: $filter)
                .padding()
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(filter: .all).environmentObject(RecordData())
    }
}
