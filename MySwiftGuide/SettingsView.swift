import SwiftUI

struct SettingsView: View {
    // Состояния для хранения настроек
    @State private var isDarkMode = false
    @State private var fontSize: Double = 16
    @State private var selectedCategory = "Все"
    
    let categories = ["Все", "Фреймворки", "Языки", "Базы данных"]
    
    var body: some View {
        NavigationView {
            Form {
                // Секция 1: Внешний вид
                Section(header: Text("Внешний вид")) {
                    Toggle("Темная тема", isOn: $isDarkMode)
                    
                    VStack(alignment: .leading) {
                        Text("Размер шрифта: \(Int(fontSize))")
                        Slider(value: $fontSize, in: 12...24, step: 1)
                    }
                }
                
                // Секция 2: Контент
                Section(header: Text("Контент")) {
                    Picker("Категория", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // Секция 3: Информация
                Section(header: Text("Информация")) {
                    HStack {
                        Text("Версия приложения")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Количество статей")
                        Spacer()
                        Text("\(Post.samplePosts.count)")
                            .foregroundColor(.secondary)
                    }
                }
                
                // Секция 4: Сброс
                Section {
                    Button(action: {
                        isDarkMode = false
                        fontSize = 16
                        selectedCategory = "Все"
                    }) {
                        Text("Сбросить настройки")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Настройки")
        }
    }
}

// Превью
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
