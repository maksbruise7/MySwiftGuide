import SwiftUI

struct InfoView: View {
    @Binding var titleOn: Bool
    
    var body: some View {
        NavigationView {
            List(Post.samplePosts) { post in
                NavigationLink(destination: InfoDetails(post: post)) {
                    InfoRow(post: post)
                }
            }
            .navigationTitle(titleOn ? "Справочник Swift" : "")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(!titleOn)  // ← КЛЮЧЕВОЙ МОМЕНТ
            .listStyle(PlainListStyle())
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(titleOn: .constant(true))
    }
}
