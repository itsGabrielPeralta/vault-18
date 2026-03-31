import SwiftUI
import SwiftData
import PhotosUI

@Observable
final class MilestoneDetailViewModel {
    let milestone: Milestone
    let child: Child
    var showingPhotoPicker = false
    var showingTextCreation = false
    var selectedPhotoItem: PhotosPickerItem?
    var isLoadingPhoto = false
    var errorMessage: String?
    var showSavedConfirmation = false

    init(milestone: Milestone, child: Child) {
        self.milestone = milestone
        self.child = child
    }

    var sortedCapsules: [TimeCapsule] {
        milestone.capsules.sorted { $0.createdAt < $1.createdAt }
    }

    @MainActor
    func handlePhotoSelection(context: ModelContext) async {
        guard let item = selectedPhotoItem else { return }
        isLoadingPhoto = true
        defer { isLoadingPhoto = false; selectedPhotoItem = nil }

        do {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                errorMessage = "No se pudo cargar la foto seleccionada."
                return
            }
            guard let relativePath = MediaStorageService.savePhoto(data: data, childID: child.id) else {
                errorMessage = "No se pudo guardar la foto. Verifica el espacio disponible."
                return
            }
            let capsule = TimeCapsule(mediaFilename: relativePath, mediaType: "photo")
            capsule.milestone = milestone
            context.insert(capsule)
            confirmSave()
        } catch {
            errorMessage = "Error al cargar la foto: \(error.localizedDescription)"
        }
    }

    func createTextCapsule(text: String, context: ModelContext) {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let capsule = TimeCapsule(text: text)
        capsule.milestone = milestone
        context.insert(capsule)
        confirmSave()
    }

    func deleteCapsule(_ capsule: TimeCapsule, context: ModelContext) {
        if let path = capsule.mediaFilename {
            MediaStorageService.deleteMedia(relativePath: path)
        }
        context.delete(capsule)
    }

    private func confirmSave() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        showSavedConfirmation = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.showSavedConfirmation = false
        }
    }
}
