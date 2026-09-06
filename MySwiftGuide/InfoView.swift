import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationView {
            List(Post.samplePosts) { post in
                NavigationLink(destination: InfoDetails(post: post)) {
                    InfoRow(post: post)
                }
            }
            .navigationTitle("Справочник Swift")
            .listStyle(PlainListStyle())
        }
    }
}

// Превью
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
