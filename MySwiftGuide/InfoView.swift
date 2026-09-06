import SwiftUI

struct InfoView: View {
    @Binding var titleOn: Bool
    @Binding var posts: [Post]
    @State private var showOnlyUnlocked = false
    
    var filteredPosts: [Post] {
        if showOnlyUnlocked {
            return posts.filter { $0.isUnlocked }
        }
        return posts
    }
    
    var unlockedCount: Int {
        posts.filter { $0.isUnlocked }.count
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Счетчик статей
                HStack {
                    Text("Доступно: \(unlockedCount)/\(posts.count) статей")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            showOnlyUnlocked.toggle()
                        }
                    }) {
                        Label(
                            showOnlyUnlocked ? "Показать все" : "Только доступные",
                            systemImage: showOnlyUnlocked ? "eye.fill" : "eye.slash.fill"
                        )
                        .font(.caption)
                    }
                }
                .padding(.horizontal)
                
                List(filteredPosts) { post in
                    if post.isUnlocked {
                        NavigationLink(destination: InfoDetails(post: post)) {
                            InfoRow(post: post)
                        }
                    } else {
                        InfoRow(post: post)
                            .disabled(true)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle(titleOn ? "Справочник Swift" : "")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(!titleOn)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(
            titleOn: .constant(true),
            posts: .constant(Post.samplePosts)
        )
    }
}
