import SwiftUI

struct InfoRow: View {
    let post: Post
    
    var body: some View {
        HStack(spacing: 12) {
            // Иконка
            post.image
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.blue.opacity(0.1))
                )
            
            // Текст
            VStack(alignment: .leading, spacing: 4) {
                Text(post.title)
                    .font(.headline)
                Text(post.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

// Превью для проверки
struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(post: Post.samplePosts[0])
            .previewLayout(.sizeThatFits)
    }
}
