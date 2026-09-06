import SwiftUI

struct ContentView: View {
    @AppStorage("isTitleOn") private var titleOn: Bool = true
    
    var body: some View {
        TabView {
            // Передаем titleOn в InfoView
            InfoView(titleOn: $titleOn)
                .tabItem {
                    Label("Статьи", systemImage: "book.fill")
                }
            
            HelloView()
                .tabItem {
                    Label("Привет", systemImage: "person.fill")
                }
            
            // ✅ НЕ передаем аргументы в SettingsView
            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
