import UIKit

enum MediaStorageService {

    private static let directoryName = "Vault18Media"

    static var baseURL: URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docs.appendingPathComponent(directoryName)
    }

    // MARK: - Save

    static func savePhoto(data: Data, childID: UUID) -> String? {
        let childDir = baseURL.appendingPathComponent(childID.uuidString)
        do {
            try FileManager.default.createDirectory(at: childDir, withIntermediateDirectories: true)
        } catch {
            return nil
        }

        let filename = "photo_\(Int(Date().timeIntervalSince1970))_\(UUID().uuidString.prefix(6)).jpg"
        let relativePath = "\(childID.uuidString)/\(filename)"
        let fullURL = baseURL.appendingPathComponent(relativePath)

        do {
            // Compress if large
            let optimized: Data
            if data.count > 2_000_000, let image = UIImage(data: data),
               let compressed = image.jpegData(compressionQuality: 0.82) {
                optimized = compressed
            } else {
                optimized = data
            }
            try optimized.write(to: fullURL)
            return relativePath
        } catch {
            return nil
        }
    }

    // MARK: - Load

    static func loadImage(relativePath: String) -> UIImage? {
        let url = baseURL.appendingPathComponent(relativePath)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }

    // MARK: - Delete

    static func deleteMedia(relativePath: String) {
        let url = baseURL.appendingPathComponent(relativePath)
        try? FileManager.default.removeItem(at: url)
    }
}
