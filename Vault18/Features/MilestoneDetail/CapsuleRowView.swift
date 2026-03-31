import SwiftUI

struct CapsuleRowView: View {
    let capsule: TimeCapsule

    var body: some View {
        VaultCard {
            VStack(alignment: .leading, spacing: Theme.spacingS) {
                // Photo
                if let path = capsule.mediaFilename {
                    CapsuleImageView(relativePath: path)
                }

                // Text
                if let text = capsule.text, !text.isEmpty {
                    Text(text)
                        .font(Theme.bodyFont)
                        .foregroundStyle(Theme.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                // Timestamp
                Text(capsule.createdAt, style: .date)
                    .font(Theme.caption)
                    .foregroundStyle(Theme.textSecondary)
            }
        }
    }
}

// MARK: - Async image loader from file system

private struct CapsuleImageView: View {
    let relativePath: String
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: Theme.radiusS))
            } else {
                RoundedRectangle(cornerRadius: Theme.radiusS)
                    .fill(Theme.marronClaro.opacity(0.1))
                    .frame(height: 220)
                    .overlay {
                        Image(systemName: "photo")
                            .font(.title2)
                            .foregroundStyle(Theme.textSecondary.opacity(0.4))
                    }
            }
        }
        .task {
            image = MediaStorageService.loadImage(relativePath: relativePath)
        }
    }
}
