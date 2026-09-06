import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isTitleOn") private var titleOn: Bool = true
    @State private var isAnimating = false
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Информация о теме")) {
                    HStack {
                        Image(systemName: colorScheme == .light ? "sun.max.fill" : "moon.fill")
                            .foregroundColor(colorScheme == .light ? .orange : .purple)
                            .rotationEffect(.degrees(rotationAngle))
                            .animation(
                                Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                                value: rotationAngle
                            )
                            .onAppear {
                                rotationAngle = 360
                            }
                        
                        Text(colorScheme == .light ? "☀️ Light Theme enabled" : "🌙 Dark Theme enabled")
                            .font(.headline)
                            .foregroundColor(colorScheme == .light ? .orange : .purple)
                    }
                    
                    HStack {
                        Text("Текущая схема:")
                        Spacer()
                        Text(colorScheme == .light ? "Светлая" : "Тёмная")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Навигация")) {
                    Toggle("Показывать заголовок", isOn: $titleOn)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    if titleOn {
                        Text("✅ Navigation title enabled")
                            .foregroundColor(.green)
                            .font(.subheadline)
                            .transition(.scale.combined(with: .opacity))
                    } else {
                        Text("❌ Navigation title disabled")
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: titleOn)
                
                Section(header: Text("О приложении")) {
                    HStack {
                        Image(systemName: "swift")
                            .font(.title2)
                            .foregroundColor(.orange)
                        
                        VStack(alignment: .leading) {
                            Text("Swift Guide")
                                .font(.headline)
                            Text("Версия 2.0.0")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Text("Интерактивный справочник с викториной")
                        .font(.caption)
                        .foregroundColor(.secondary)
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
