import SwiftUI

struct InfoDetails: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Верхняя часть с иконкой и заголовком
                HStack {
                    post.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                    
                    Text(post.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                
                Divider()
                
                // Блок "Описание"
                VStack(alignment: .leading, spacing: 8) {
                    Text("Описание")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(post.description)
                        .font(.body)
                }
                .padding(.horizontal)
                
                // Блок "Подробная информация"
                VStack(alignment: .leading, spacing: 8) {
                    Text("Подробная информация")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(post.detailedInfo)
                        .font(.body)
                        .lineSpacing(4)
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

// Превью
struct InfoDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InfoDetails(post: Post.samplePosts[0])
        }
    }
}
