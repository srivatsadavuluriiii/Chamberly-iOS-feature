import SwiftUI
struct CommentView: View {
    @State private var isSelected: Bool = false
    let isPost: Bool = false
    let reply: Reply
    @State private var newReplyText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(reply.authorName)
                    .font(.headline)
                Spacer()
                Menu {
                    Button("Report User") {

                    }
                    Button("Report Message") {
                        
                    }
                } label: {
                    Image("dots")
                }

            }
            Text(reply.replyContent)
                .font(.footnote)
            
            if !reply.replies.isEmpty {
                ForEach(reply.replies) { childReply in
                    CommentView(reply: childReply)
                        .padding(.horizontal)
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
    
    func onReplyAppended(text: String) {
        reply.replies.append(Reply(id: UUID(), authorName: "You", replyContent: text))
    }
}

struct ModifyRepliesView: View {
    @State var mutableReply: Reply
    var onReply: (String) -> Void
    
    var body: some View {
        CommentsView(comments: mutableReply.replies, onReply: onReply, showAllReplies: .constant(true))
            .onAppear {
                self.mutableReply = self.mutableReply
            }
    }

    init(reply: Reply, onReply: @escaping (String) -> Void) {
        self._mutableReply = State(initialValue: reply)
        self.onReply = onReply
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
            if comments.count>0  {
                Button(action: { showAllReplies.toggle() }) {
                    Text(showAllReplies ? "Hide all replies" : "Show all replies")
                        .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
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
