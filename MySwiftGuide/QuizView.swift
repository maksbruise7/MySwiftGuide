import SwiftUI

struct QuizView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: Int?
    @State private var isAnswerCorrect = false
    @State private var showResult = false
    @State private var score = 0
    @State private var answeredQuestions = 0
    @State private var unlockedPosts: [Int] = []
    @State private var showCelebration = false
    @State private var rotationAngle: Double = 0
    @State private var scaleEffect: CGFloat = 1.0
    
    @Binding var posts: [Post]
    @Binding var titleOn: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                // Фоновый градиент
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Заголовок с анимацией
                    HStack {
                        Image(systemName: "brain.head.profile")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                            .rotationEffect(.degrees(rotationAngle))
                            .animation(
                                Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                                value: rotationAngle
                            )
                            .onAppear {
                                rotationAngle = 360
                            }
                        
                        Text("Викторина по Swift")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 20)
                    
                    // Прогресс
                    VStack {
                        ProgressView(value: Double(answeredQuestions), total: Double(quizQuestions.count))
                            .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                        
                        Text("Прогресс: \(answeredQuestions)/\(quizQuestions.count)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    if currentQuestionIndex < quizQuestions.count {
                        // Вопрос
                        QuizQuestionView(
                            question: quizQuestions[currentQuestionIndex],
                            selectedAnswer: $selectedAnswer,
                            isAnswerCorrect: $isAnswerCorrect,
                            showResult: $showResult,
                            onAnswerSelected: { isCorrect in
                                handleAnswer(isCorrect: isCorrect)
                            }
                        )
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.systemBackground))
                                .shadow(color: .gray.opacity(0.3), radius: 10)
                        )
                        .padding(.horizontal)
                        .scaleEffect(scaleEffect)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: scaleEffect)
                        
                        // Кнопка "Следующий вопрос"
                        if showResult {
                            Button(action: nextQuestion) {
                                Label(
                                    answeredQuestions < quizQuestions.count ? "Следующий вопрос" : "Узнать результаты",
                                    systemImage: "arrow.right.circle.fill"
                                )
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                            }
                            .padding(.horizontal)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    } else {
                        // Экран результатов
                        QuizResultsView(
                            score: score,
                            totalQuestions: quizQuestions.count,
                            unlockedPosts: unlockedPosts,
                            posts: $posts,
                            titleOn: $titleOn,
                            onRestart: restartQuiz
                        )
                        .transition(.scale.combined(with: .opacity))
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(!titleOn)
            .navigationTitle(titleOn ? "Викторина" : "")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            // Загружаем сохраненный прогресс
            loadProgress()
        }
    }
    
    // MARK: - Функции обработки
    
    private func handleAnswer(isCorrect: Bool) {
        if isCorrect {
            score += 1
            let postIndex = quizQuestions[currentQuestionIndex].relatedPostIndex
            if !unlockedPosts.contains(postIndex) {
                unlockedPosts.append(postIndex)
                // Анимация открытия новой статьи
                withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                    posts[postIndex].isUnlocked = true
                }
                showCelebration = true
                
                // Скрываем празднование через 2 секунды
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showCelebration = false
                }
            }
        }
        answeredQuestions += 1
        showResult = true
        
        // Анимация при ответе
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            scaleEffect = isCorrect ? 1.05 : 0.95
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                scaleEffect = 1.0
            }
        }
        
        // Сохраняем прогресс
        saveProgress()
    }
    
    private func nextQuestion() {
        withAnimation(.easeInOut(duration: 0.5)) {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showResult = false
            isAnswerCorrect = false
            scaleEffect = 1.0
        }
    }
    
    private func restartQuiz() {
        withAnimation(.easeInOut(duration: 0.5)) {
            currentQuestionIndex = 0
            selectedAnswer = nil
            showResult = false
            isAnswerCorrect = false
            score = 0
            answeredQuestions = 0
            unlockedPosts.removeAll()
            scaleEffect = 1.0
            rotationAngle = 0
            
            // Сбрасываем unlocked статус для всех постов кроме первых трех
            for i in 0..<posts.count {
                if i < 3 {
                    posts[i].isUnlocked = true
                } else {
                    posts[i].isUnlocked = false
                }
            }
            
            // Сохраняем прогресс
            saveProgress()
        }
    }
    
    private func saveProgress() {
        UserDefaults.standard.set(score, forKey: "quizScore")
        UserDefaults.standard.set(answeredQuestions, forKey: "quizAnsweredQuestions")
        UserDefaults.standard.set(unlockedPosts, forKey: "quizUnlockedPosts")
    }
    
    private func loadProgress() {
        score = UserDefaults.standard.integer(forKey: "quizScore")
        answeredQuestions = UserDefaults.standard.integer(forKey: "quizAnsweredQuestions")
        if let savedUnlocked = UserDefaults.standard.array(forKey: "quizUnlockedPosts") as? [Int] {
            unlockedPosts = savedUnlocked
            for index in savedUnlocked {
                if index < posts.count {
                    posts[index].isUnlocked = true
                }
            }
        }
    }
}

// MARK: - Вспомогательные компоненты

struct QuizQuestionView: View {
    let question: QuizQuestion
    @Binding var selectedAnswer: Int?
    @Binding var isAnswerCorrect: Bool
    @Binding var showResult: Bool
    let onAnswerSelected: (Bool) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Вопрос \(question.id.hashValue % 10 + 1)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Text(question.question)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            ForEach(0..<question.options.count, id: \.self) { index in
                QuizOptionView(
                    text: question.options[index],
                    isSelected: selectedAnswer == index,
                    isCorrect: showResult ? (index == question.correctAnswer) : false,
                    isWrong: showResult && selectedAnswer == index && selectedAnswer != question.correctAnswer,
                    isDisabled: showResult
                )
                .onTapGesture {
                    if !showResult {
                        selectedAnswer = index
                        let isCorrect = index == question.correctAnswer
                        isAnswerCorrect = isCorrect
                        onAnswerSelected(isCorrect)
                    }
                }
                .disabled(showResult)
            }
            
            if showResult {
                HStack {
                    Image(systemName: isAnswerCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(isAnswerCorrect ? .green : .red)
                        .font(.title2)
                    
                    Text(isAnswerCorrect ? "Правильно! 🎉" : "Неправильно. Правильный ответ: \(question.options[question.correctAnswer])")
                        .font(.headline)
                        .foregroundColor(isAnswerCorrect ? .green : .red)
                }
                .padding(.horizontal)
                .transition(.opacity)
            }
        }
        .padding(.vertical)
    }
}

struct QuizOptionView: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let isDisabled: Bool
    
    var body: some View {
        HStack {
            Text(text)
                .font(.body)
                .padding(.leading)
            
            Spacer()
            
            if isDisabled {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isCorrect ? .green : .gray)
                    .padding(.trailing)
            }
        }
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor, lineWidth: isSelected ? 2 : 0)
                )
        )
        .padding(.horizontal)
        .scaleEffect(isSelected && !isDisabled ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
    
    var backgroundColor: Color {
        if isDisabled {
            if isCorrect {
                return Color.green.opacity(0.2)
            } else if isWrong {
                return Color.red.opacity(0.2)
            } else {
                return Color(.systemGray6)
            }
        } else {
            return isSelected ? Color.blue.opacity(0.2) : Color(.systemGray6)
        }
    }
    
    var borderColor: Color {
        if isDisabled {
            if isCorrect {
                return .green
            } else if isWrong {
                return .red
            } else {
                return .clear
            }
        } else {
            return isSelected ? .blue : .clear
        }
    }
}

struct QuizResultsView: View {
    let score: Int
    let totalQuestions: Int
    let unlockedPosts: [Int]
    @Binding var posts: [Post]
    @Binding var titleOn: Bool
    let onRestart: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "trophy.fill")
                .font(.system(size: 80))
                .foregroundColor(.yellow)
                .shadow(color: .yellow.opacity(0.5), radius: 20)
                .rotationEffect(.degrees(360))
                .animation(
                    Animation.linear(duration: 10).repeatForever(autoreverses: false),
                    value: UUID()
                )
            
            Text("Викторина завершена!")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Ваш результат: \(score)/\(totalQuestions)")
                .font(.title2)
                .foregroundColor(score == totalQuestions ? .green : .blue)
            
            if !unlockedPosts.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    Text("🎉 Открытые статьи:")
                        .font(.headline)
                    
                    ForEach(unlockedPosts, id: \.self) { index in
                        if index < posts.count {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text(posts[index].title)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.1))
                )
            }
            
            Button(action: onRestart) {
                Label("Начать заново", systemImage: "arrow.clockwise.circle.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(
            posts: .constant(Post.samplePosts),
            titleOn: .constant(true)
        )
    }
}
