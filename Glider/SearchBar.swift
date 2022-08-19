//
//  SearchBar.swift
//  Glider
//
//  Created by Christopher Leibiger on 19.08.22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText : String
    @FocusState var searchIsFocused: Bool
    @Binding var isExpanded: Bool
    
     var body: some View {
         HStack{
             ZStack {
                 Rectangle()
                     .foregroundColor(Color("LightGray"))
                 HStack {
                     Image(systemName: "magnifyingglass")
                     TextField("Search ..", text: $searchText)
                         .focused($searchIsFocused)
                         .onChange(of: searchIsFocused) { isFocused in
                             if !searchIsFocused && isExpanded
                             {}
                             else {
                                 withAnimation { self.isExpanded = false }
                             }}
                     //Delete input button
                     if !searchText.isEmpty
                     {
                         Button(action:
                                    {
                             self.searchText = ""
                         })
                         {
                             Image(systemName: "delete.left")
                             //  .foregroundColor(Color(UIColor.opaqueSeparator))
                         }
                         .padding(.trailing, 8)
                     }
                 }
                 .foregroundColor(.gray)
                 .padding(.leading, 13)
                 
                 
                 
             }
             .frame(width: 200, height: 30)
             .cornerRadius(13)
             .padding([.top, .leading, .bottom])
             
             if searchIsFocused {
                 Button("Done", action: {searchIsFocused = false
                 })
             }
         }
    
     }
 }

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), isExpanded: .constant(false))
    }
}
