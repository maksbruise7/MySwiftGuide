import Foundation

struct QuizQuestion {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: Int
    let relatedPostIndex: Int // Индекс статьи, которая открывается при правильном ответе
}

// Массив вопросов для викторины
let quizQuestions = [
    QuizQuestion(
        question: "В каком году был представлен Swift?",
        options: ["2010", "2014", "2016", "2018"],
        correctAnswer: 1,
        relatedPostIndex: 0 // Swift
    ),
    QuizQuestion(
        question: "Какой фреймворк использует декларативный синтаксис?",
        options: ["UIKit", "AppKit", "SwiftUI", "WatchKit"],
        correctAnswer: 2,
        relatedPostIndex: 1 // SwiftUI
    ),
    QuizQuestion(
        question: "Что из перечисленного является реактивным фреймворком?",
        options: ["CoreData", "Combine", "UIKit", "Foundation"],
        correctAnswer: 1,
        relatedPostIndex: 3 // Combine
    ),
    QuizQuestion(
        question: "Какой фреймворк используется для работы с базой данных?",
        options: ["CoreData", "SwiftUI", "Combine", "UIKit"],
        correctAnswer: 0,
        relatedPostIndex: 4 // CoreData
    ),
    QuizQuestion(
        question: "В какой версии Swift появился Async/Await?",
        options: ["5.3", "5.4", "5.5", "5.6"],
        correctAnswer: 2,
        relatedPostIndex: 5 // Async/Await
    )
]
