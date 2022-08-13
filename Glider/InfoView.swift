//
//  InfoView.swift
//  Glider
//
//  Created by Christopher Leibiger on 12.08.22.
//

import SwiftUI

struct InfoView: View {
    var body: some View {

            List{
                Section("Über") {
                    Text("Glider ist eine App zur Erfassung von Zeiten")
                }
                Section("Bedienung") {
                    HStack {
                        Image(systemName: "calendar.badge.plus")
                            .font(.title)
                            .padding()
                            .foregroundColor(.green)
                        VStack(alignment: .leading){Text("Eintrag erstellen")
                                .bold()
                            Text("Tippe auf das + Symbol, um einen neuen Eintrag zu erstellen")
                        }
                        .padding()
                        
                    }
                    HStack {
                        Image(systemName: "calendar.badge.minus")
                            .font(.title)
                            .padding()
                            .foregroundColor(.red)
                        VStack(alignment: .leading){Text("Eintrag löschen")
                                .bold()
                            Text("Um einen Eintrag zu löschen, swipe nach links")
                        }
                        .padding()
                        
                    }
                }
        Section ("Copyright") {
            Text("© 2022 Christopher Leibiger")
        }
        
            }
    
    
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
}
