import SwiftUI

struct HelloView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Иконка
            Image(systemName: "book.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            // Заголовок
            Text("Hello world")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Подзаголовки
            Text("Добро пожаловать в справочник по Swift!")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Здесь вы найдете информацию о ключевых технологиях Apple")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

// Превью
struct HelloView_Previews: PreviewProvider {
    static var previews: some View {
        HelloView()
    }
}
