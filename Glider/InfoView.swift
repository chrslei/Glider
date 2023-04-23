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
                        .padding(5)
                        
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
                        .padding(5)
                        
                    }
                    HStack {
                        Image(systemName: "mail.and.text.magnifyingglass")
                            .font(.title)
                            .padding()
                            .padding(.trailing, -4)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading){Text("Einträge suchen")
                                .bold()
                            Text("Füge beim Erstellen von Einträgen Tags hinzu, um nach ihnen zu suchen")
                                .clipped()
                        }
                        .padding(5)
                        
                    }
                }
        Section ("Copyright") {
            Text("© 2023 Christopher Leibiger")
                .font(.footnote)
            Text("Kontakt: info@abbildung.org")
                .font(.footnote)
              
        }
        
            }
    
    
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
}
