import SwiftUI

struct PostCardView: View {
    @State private var showAllReplies = false
    @State private var isLiked: Bool = false
    @Binding var selectedCommentIndex: Int?
    @Binding var post: Post
    @State private var replyText = ""
    @State private var showReplyField = false // Track if reply field is visible

    init(selectedCommentIndex: Binding<Int?>, post: Binding<Post>) {
        self._selectedCommentIndex = selectedCommentIndex
        self._post = post
    }

    func onAddReply() {
        if let index = selectedCommentIndex {
            let newReply = Reply(id: UUID(), authorName: "You", replyContent: replyText)
            post.comments.append(newReply) // Add the reply directly to the post comments
            showReplyField = false
            replyText = ""
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CommentView(reply: Reply(id: post.id, authorName: post.authorName, replyContent: post.content))

                HStack(spacing: 20) {
                    HStack(spacing: 3) {
                        Button {
                            isLiked.toggle()
                            if isLiked {
                                post.totalLikes += 1
                            } else {
                                post.totalLikes -= 1
                            }
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                        Text("\(post.totalLikes)")
                    }

                    HStack(spacing: 3) {
                        Button(action: {
                            selectedCommentIndex = 0
                            showReplyField.toggle()
                        }) {
                            Image(systemName: "message")
                                .foregroundColor(Color.blue)
                        }
                        Text("\(post.comments.count)")
                    }
                }
                .padding(.horizontal, 20)

                if showReplyField {
                    HStack {
                        VStack {
                            TextField("Write your reply...", text: $replyText, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        Button(action: {
                            onAddReply()
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 20)
                }

                if !post.comments.isEmpty {
                    if showAllReplies {
                        CommentsView(
                            comments: post.comments,
                            onReply: { replyText in
                                let newReply = Reply(id: UUID(), authorName: "You", replyContent: replyText)
                                post.comments.append(newReply)
                            },
                            showAllReplies: $showAllReplies
                        )
                        .padding(.bottom, 20)
                    } else {
                        if post.comments.count > 0 && !showAllReplies {
                            Button(action: { showAllReplies.toggle() }) {
                                Text("Show all replies")
                                    .padding()
                                    .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
                            }
                        }
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 0.5)
        }
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        let selectedCommentIndex: Binding<Int?> = .constant(0)
        let post = Post(content: "Sample content", authorName: "John", comments: [], totalLikes: 10)
        return PostCardView(selectedCommentIndex: selectedCommentIndex, post: .constant(post))
    }
}
