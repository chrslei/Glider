
import SwiftUI

struct TestView: View {
    @State private var selection = Tabs.inbox
    
    private enum Tabs: Hashable {
        case inbox
        case projects
        case settings
    }
    
    var body: some View {
        VStack{
        TabView(selection: $selection){
            Text("This will be inbox")
                .font(.title)
             
            .tag(Tabs.inbox)
            Text("This will be projects")
                .font(.title)
           
            .tag(Tabs.projects)
            Text("This will be settings")
                .font(.title)
            .tag(Tabs.settings)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
    }
        .background(.gray)
}
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
