import Foundation

class Post: Identifiable, ObservableObject, Equatable, Hashable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id = UUID()
    let content: String
    var authorName: String
    @Published var comments: [Reply]
    var totalLikes: Int
    var timestamp: Date

    init(content: String, authorName: String, comments: [Reply] = [], totalLikes: Int = 0, timestamp: Date? = nil) {
        self.content = content
        self.authorName = authorName
        self.comments = comments
        self.totalLikes = totalLikes
        self.timestamp = timestamp ?? Date() // Use current timestamp if not provided
    }

    func addReply(text: String) {
        let newReply = Reply(authorName: "You", replyContent: text)
        comments.append(newReply)
    }
}

class Reply: Identifiable {
    let id = UUID()
    let authorName: String
    let replyContent: String
    var likeCount: Int
    var isLiked: Bool
    var replies: [Reply]

    init(authorName: String, replyContent: String, likeCount: Int = 0, isLiked: Bool = false, replies: [Reply] = []) {
        self.authorName = authorName
        self.replyContent = replyContent
        self.likeCount = likeCount
        self.isLiked = isLiked
        self.replies = replies
    }
}
