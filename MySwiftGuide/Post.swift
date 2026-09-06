import SwiftUI

struct Post: Identifiable {
    var id = UUID()  // Уникальный идентификатор для каждой записи
    var title: String
    var description: String
    var image: Image
    var detailedInfo: String
}

// Добавим примеры данных для тестирования
extension Post {
    static let samplePosts = [
        Post(
            title: "Swift",
            description: "Мощный язык программирования от Apple",
            image: Image(systemName: "swift"),
            detailedInfo: "Swift был разработан Apple в 2014 году. Это безопасный и быстрый язык."
        ),
        Post(
            title: "SwiftUI",
            description: "Современный фреймворк для UI",
            image: Image(systemName: "square.stack.3d.up.fill"),
            detailedInfo: "SwiftUI представлен в 2019 году. Использует декларативный синтаксис."
        ),
        Post(
            title: "UIKit",
            description: "Классический фреймворк для интерфейсов",
            image: Image(systemName: "rectangle.fill.on.rectangle.fill"),
            detailedInfo: "UIKit существует с 2007 года. Основа для большинства iOS-приложений."
        ),
        Post(
            title: "Combine",
            description: "Фреймворк для асинхронных событий",
            image: Image(systemName: "arrow.triangle.merge"),
            detailedInfo: "Combine представлен в 2019 году. Использует реактивный подход."
        ),
        Post(
            title: "CoreData",
            description: "Фреймворк для управления данными",
            image: Image(systemName: "database"),
            detailedInfo: "CoreData существует с 2009 года. Работает с базой данных."
        )
    ]
}
