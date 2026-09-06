import SwiftUI

struct Post: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var image: Image
    var detailedInfo: String
    var isUnlocked: Bool = false
}

// Расширение для примеров данных
extension Post {
    static let samplePosts = [
        Post(
            title: "Swift",
            description: "Мощный язык программирования от Apple",
            image: Image(systemName: "swift"),
            detailedInfo: "Swift был разработан Apple в 2014 году. Это безопасный и быстрый язык программирования с открытым исходным кодом.",
            isUnlocked: true
        ),
        Post(
            title: "SwiftUI",
            description: "Современный фреймворк для UI",
            image: Image(systemName: "square.stack.3d.up.fill"),
            detailedInfo: "SwiftUI представлен в 2019 году. Использует декларативный синтаксис для создания интерфейсов на всех платформах Apple.",
            isUnlocked: true
        ),
        Post(
            title: "UIKit",
            description: "Классический фреймворк для интерфейсов",
            image: Image(systemName: "rectangle.fill.on.rectangle.fill"),
            detailedInfo: "UIKit существует с 2007 года. Основа для большинства iOS-приложений с императивным подходом.",
            isUnlocked: true
        ),
        Post(
            title: "Combine",
            description: "Фреймворк для асинхронных событий",
            image: Image(systemName: "arrow.triangle.merge"),
            detailedInfo: "Combine представлен в 2019 году. Использует реактивный подход с паблишерами и операторами.",
            isUnlocked: false
        ),
        Post(
            title: "CoreData",
            description: "Фреймворк для управления данными",
            image: Image(systemName: "database"),
            detailedInfo: "CoreData существует с 2009 года. Обеспечивает объектно-ориентированный API для работы с базой данных.",
            isUnlocked: false
        ),
        Post(
            title: "Async/Await",
            description: "Современный подход к асинхронности",
            image: Image(systemName: "arrow.triangle.2.circlepath"),
            detailedInfo: "Async/await представлен в Swift 5.5. Упрощает работу с асинхронным кодом, делая его более читаемым.",
            isUnlocked: false
        )
    ]
}
