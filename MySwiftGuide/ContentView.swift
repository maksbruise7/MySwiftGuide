import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Вкладка 1: Список статей
            InfoView()
                .tabItem {
                    Label("Статьи", systemImage: "book.fill")
                }
            
            // Вкладка 2: Приветствие
            HelloView()
                .tabItem {
                    Label("Привет", systemImage: "person.fill")
                }
            
            // Вкладка 3: Настройки
            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gear")
                }
        }
    }
}

// Превью
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
