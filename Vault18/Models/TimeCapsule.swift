import SwiftData
import Foundation

@Model
final class TimeCapsule {
    var id: UUID
    var text: String?
    var mediaFilename: String?
    var mediaType: String?
    var createdAt: Date

    var milestone: Milestone?

    var hasMedia: Bool {
        mediaFilename != nil
    }

    var hasText: Bool {
        if let text, !text.isEmpty { return true }
        return false
    }

    init(text: String? = nil, mediaFilename: String? = nil, mediaType: String? = nil) {
        self.id = UUID()
        self.text = text
        self.mediaFilename = mediaFilename
        self.mediaType = mediaType
        self.createdAt = Date()
    }
}
