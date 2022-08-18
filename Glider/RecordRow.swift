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
                    .scaledToFill()
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                Spacer()
                VStack (alignment: .leading){
                    Text(record.start.formatted(date: .omitted, time: .shortened) + " – " + record.end.formatted(date: .omitted, time: .shortened) )
                        .scaledToFill()
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                    if record.note != "" {
                        Text("#" + record.note)
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                }
                    Spacer()
                    Spacer()
                
                Text(record.durationInMinutesAsString)
                    .foregroundColor(.green)
                    .bold()
                    .scaledToFill()
                    .padding(.trailing)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .frame(width: 20, alignment: .trailing)
                
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

extension UIViewController {
func dismissKeyboard() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}
