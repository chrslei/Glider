//
//  ContentView.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI

//adjust divider length above ContentCreator
func getPadding(_ isExpanded: Bool) -> CGFloat {
        if !isExpanded {
                return CGFloat(120)
        }
            
        return CGFloat(30)
}


struct ContentView: View {
    @EnvironmentObject var recordData: RecordData
    @State var newRecord = Record()
    @State var filter : Period
    @State var info = false
    @State private var isExpanded = true
    @State var searchText : String

    
    var body: some View {
      
        VStack (alignment: .leading) {
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
               //.padding(.top, +10)
                .navigationTitle("")
                .navigationBarHidden(true)
            
            
                SearchBar(searchText: $searchText, isExpanded: $isExpanded)
                    .padding(.top, -20)
                    .padding(.bottom, -12)
               
                
               //     .padding(.trailing, 100)
                RangePicker(filter: $filter)
                    .padding(.horizontal)
             
                RecordList(filter: $filter, searchText: $searchText)
                   
            
                
                Capsule()
                    .foregroundColor(.gray
                        .opacity(0.25))
                    .frame(height: 4.0)
                    .padding(.horizontal, getPadding(isExpanded))
                
                
                Button(action : {withAnimation { self.isExpanded.toggle() }}) {
                    Image(systemName: "chevron.down")
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                        .foregroundColor(.gray)
                        .font(.footnote.bold())
                        .frame(height: 15)
                        .frame(maxWidth: .infinity)
                }
                .rotationEffect(Angle.degrees(!isExpanded ? 180 : 0))
               
                
                
                if isExpanded {
                    RecordCreator(record: newRecord, filter: $filter)
                        .padding(.horizontal)
                        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                }
                
                
            }
        
            
        }
    
        
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(filter: .all, searchText: "").environmentObject(RecordData())
    }
}
