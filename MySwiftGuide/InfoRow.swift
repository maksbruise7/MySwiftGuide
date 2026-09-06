import SwiftUI

struct InfoRow: View {
    let post: Post
    
    var body: some View {
        HStack(spacing: 12) {
            post.image
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(post.isUnlocked ? .blue : .gray)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(post.isUnlocked ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(post.title)
                        .font(.headline)
                        .foregroundColor(post.isUnlocked ? .primary : .secondary)
                    
                    if !post.isUnlocked {
                        Image(systemName: "lock.fill")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Text(post.description)
                    .font(.subheadline)
                    .foregroundColor(post.isUnlocked ? .secondary : .gray)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
        .opacity(post.isUnlocked ? 1.0 : 0.6)
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(post: Post.samplePosts[0])
            .previewLayout(.sizeThatFits)
    }
}
