import SwiftUI

struct InfoDetails: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    post.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(post.isUnlocked ? .blue : .gray)
                    
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        if !post.isUnlocked {
                            HStack {
                                Image(systemName: "lock.fill")
                                    .font(.caption)
                                Text("Закрыто. Пройдите викторину, чтобы открыть!")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 2)
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Описание")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(post.description)
                        .font(.body)
                        .opacity(post.isUnlocked ? 1.0 : 0.6)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Подробная информация")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(post.detailedInfo)
                        .font(.body)
                        .lineSpacing(4)
                        .opacity(post.isUnlocked ? 1.0 : 0.6)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 30)
            }
            .padding(.vertical)
        }
        .navigationTitle(post.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InfoDetails(post: Post.samplePosts[0])
        }
    }
}
