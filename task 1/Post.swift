//
//  Post.swift
//  task 1
//
//  Created by srivatsa davuluri on 02/02/24.
//

import Foundation

class Post: Identifiable, ObservableObject, Hashable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    let id = UUID()
    let content: String
    var authorName: String
    
    @Published var comments: [Reply]
    var totalLikes: Int

    init(content: String, authorName: String, comments: [Reply] = [], totalLikes: Int = 0) {
        self.content = content
        self.authorName = "Hello"
        self.comments = comments.sorted(by: { $0.id.uuidString < $1.id.uuidString })
        self.totalLikes = totalLikes
    }

    func addReply(text: String) {
        comments.append(Reply(id: UUID(), authorName: "You", replyContent: text))
        comments.sort(by: { $0.id.uuidString < $1.id.uuidString })
    }
}



class Reply: Identifiable {
    let id: UUID
    let authorName: String
    let replyContent: String
    var likeCount: Int
    var isLiked: Bool
    var replies: [Reply]

    init(id: UUID = UUID(), authorName: String, replyContent: String, likeCount: Int = 0, isLiked: Bool = false, replies: [Reply] = []) {
        self.id = id
        self.authorName = authorName
        self.replyContent = replyContent
        self.likeCount = likeCount
        self.isLiked = isLiked
        self.replies = replies
    }
}

