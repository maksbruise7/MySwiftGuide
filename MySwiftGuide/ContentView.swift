import SwiftUI

struct ContentView: View {
    @AppStorage("isTitleOn") private var titleOn: Bool = true
    @State private var posts = Post.samplePosts
    
    var body: some View {
        TabView {
            InfoView(titleOn: $titleOn, posts: $posts)
                .tabItem {
                    Label("Статьи", systemImage: "book.fill")
                }
            
            QuizView(posts: $posts, titleOn: $titleOn)
                .tabItem {
                    Label("Викторина", systemImage: "brain.head.profile")
                }
            
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
