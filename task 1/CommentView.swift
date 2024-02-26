import SwiftUI
struct CommentView: View {
    @State private var isSelected: Bool = false
    let isPost: Bool = false
    let reply: Reply
    @State private var newReplyText = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(reply.authorName)
                    .font(.headline)
                Spacer()
                Menu {
                    Button("Report User") {
                        // Action for reporting user
                    }
                    Button("Report Message") {
                        // Action for reporting message
                    }
                } label: {
                    Image("dots")
                }
            }
            if numberOfWords(in: reply.replyContent) > 5 {
                if isSelected {
                    Text(reply.replyContent)
                        .font(.footnote)
                    Button(action: {
                        isSelected.toggle()
                    }) {
                        Text("View Less")
                            .foregroundColor(Color(#colorLiteral(red: 0.4784063697, green: 0.4784510732, blue: 1, alpha: 1)))
                            
                    }
                } else {
                    Text(String(reply.replyContent.split(separator: " ").prefix(5).joined(separator: " ")))
                        .font(.footnote)
                    Button(action: {
                        isSelected.toggle()
                    }) {
                        Text("View More")
                            .foregroundColor(Color(#colorLiteral(red: 0.4784063697, green: 0.4784510732, blue: 1, alpha: 1)))
                            
                    }
                }
            } else {
                Text(reply.replyContent)
                    .font(.footnote)
            }
            
            if !reply.replies.isEmpty {
                ForEach(reply.replies) { childReply in
                    CommentView(reply: childReply)
                        .padding(.leading, 20) // Adjust padding for nested replies
                }
            }
            
            if isPost {
                HStack {
                    TextField("Add a reply", text: $newReplyText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        onReplyAppended(text: newReplyText)
                        newReplyText = ""
                    }) {
                        Text("Send")
                    }
                }
                .padding(.top)
            }
        }
        .padding(15)
    }

    func numberOfWords(in text: String) -> Int {
        let words = text.split(separator: " ")
        return words.count
    }

    func onReplyAppended(text: String) {
        reply.replies.append(Reply(id: UUID(), authorName: "You", replyContent: text))
    }
}

struct CommentsView: View {
    let comments: [Reply]
    let onReply: (String) -> Void
    @Binding var showAllReplies: Bool

    var body: some View {
        VStack(spacing: 5) {
            ForEach(showAllReplies ? comments : Array(comments.prefix(2))) { reply in
                CommentView(reply: reply)
                    .padding(.horizontal)
            }
            if comments.count > 2 {
                Button(action: {
                    withAnimation {
                        showAllReplies.toggle()
                    }
                }) {
                    Text(showAllReplies ? "Hide all replies" : "Show all replies")
                        .foregroundColor(Color.blue)
                }
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(reply: Reply(id: UUID(), authorName: "Tester", replyContent: "hello", likeCount: 20, isLiked: true, replies: [Reply(authorName: "Srivatsa", replyContent: "hi")]))

    }
}
