import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isTitleOn") private var titleOn: Bool = true
    
    @State private var isDarkMode = false
    @State private var fontSize: Double = 16
    @State private var selectedCategory = "Все"
    
    let categories = ["Все", "Фреймворки", "Языки", "Базы данных"]
    
    var body: some View {
        NavigationView {
            Form {
                // Секция 1: Информация о теме
                Section(header: Text("Информация о теме")) {
                    HStack {
                        Image(systemName: colorScheme == .light ? "sun.max.fill" : "moon.fill")
                            .foregroundColor(colorScheme == .light ? .orange : .purple)
                            .font(.title2)
                        
                        Text(colorScheme == .light ? "☀️ Light Theme enabled" : "🌙 Dark Theme enabled")
                            .font(.headline)
                            .foregroundColor(colorScheme == .light ? .orange : .purple)
                    }
                    
                    HStack {
                        Text("Текущая схема:")
                        Spacer()
                        Text(colorScheme == .light ? "Светлая" : "Тёмная")
                            .foregroundColor(colorScheme == .light ? .orange : .purple)
                            .fontWeight(.medium)
                    }
                }
                
                // Секция 2: Внешний вид
                Section(header: Text("Внешний вид")) {
                    HStack {
                        Text("Темная тема")
                        Spacer()
                        Text("Управляется системой")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    
                    Toggle("Использовать темную тему", isOn: $isDarkMode)
                        .disabled(true)
                        .onAppear {
                            // Синхронизируем с системной темой
                            isDarkMode = colorScheme == .dark
                        }
                    
                    VStack(alignment: .leading) {
                        Text("Размер шрифта: \(Int(fontSize))")
                        Slider(value: $fontSize, in: 12...24, step: 1)
                    }
                }
                
                // Секция 3: Навигация
                Section(header: Text("Навигация")) {
                    Toggle("Показывать заголовок", isOn: $titleOn)
                    
                    if titleOn {
                        Text("✅ Navigation title enabled")
                            .foregroundColor(.green)
                            .font(.subheadline)
                    } else {
                        Text("❌ Navigation title disabled")
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }
                }
                
                // Секция 4: Контент
                Section(header: Text("Контент")) {
                    Picker("Категория", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // Секция 5: Информация о приложении
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
                
                // Секция 6: Сброс
                Section {
                    Button(action: {
                        isDarkMode = false
                        fontSize = 16
                        selectedCategory = "Все"
                        titleOn = true
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
