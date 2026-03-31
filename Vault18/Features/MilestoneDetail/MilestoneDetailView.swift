import SwiftUI
import SwiftData
import PhotosUI

struct MilestoneDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var vm: MilestoneDetailViewModel
    @State private var noteText = ""
    @State private var showingNoteSheet = false

    private static let notePlaceholders = [
        "Cuéntale sobre su primer paseo...",
        "¿Qué le dirías hoy?",
        "Describe este momento para que lo recuerde...",
        "¿Qué es lo que más te emociona de esta etapa?",
        "Escríbele algo que quieras que sepa...",
    ]

    init(milestone: Milestone, child: Child) {
        self._vm = State(initialValue: MilestoneDetailViewModel(milestone: milestone, child: child))
    }

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: Theme.spacingM) {
                    milestoneHeader

                    if vm.sortedCapsules.isEmpty {
                        EmptyStateView(
                            message: "Este hito está esperando\nsus primeros recuerdos.",
                            actionTitle: "Agregar recuerdo",
                            action: { vm.showingPhotoPicker = true }
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.top, Theme.spacingXL)
                    } else {
                        ForEach(vm.sortedCapsules, id: \.id) { capsule in
                            CapsuleRowView(capsule: capsule)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        vm.deleteCapsule(capsule, context: modelContext)
                                    } label: {
                                        Label("Eliminar", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal, Theme.spacingM)
                .padding(.bottom, 100)
            }

            // FAB
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    fabMenu
                }
                .padding(.trailing, Theme.spacingL)
                .padding(.bottom, Theme.spacingL)
            }

            // Save confirmation toast
            if vm.showSavedConfirmation {
                VStack {
                    savedToast
                        .transition(.move(edge: .top).combined(with: .opacity))
                    Spacer()
                }
                .padding(.top, Theme.spacingXL)
                .animation(.spring(response: 0.4, dampingFraction: 0.75), value: vm.showSavedConfirmation)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Theme.background, for: .navigationBar)
        .photosPicker(
            isPresented: $vm.showingPhotoPicker,
            selection: $vm.selectedPhotoItem,
            matching: .images,
            photoLibrary: .shared()
        )
        .onChange(of: vm.selectedPhotoItem) { _, _ in
            Task {
                await vm.handlePhotoSelection(context: modelContext)
            }
        }
        .sheet(isPresented: $showingNoteSheet) {
            noteCreationSheet
        }
        .alert("Error", isPresented: .init(
            get: { vm.errorMessage != nil },
            set: { if !$0 { vm.errorMessage = nil } }
        )) {
            Button("Aceptar", role: .cancel) { vm.errorMessage = nil }
        } message: {
            Text(vm.errorMessage ?? "")
        }
        .overlay {
            if vm.isLoadingPhoto {
                Color.clear
                    .overlay {
                        ProgressView()
                            .tint(Theme.primary)
                            .scaleEffect(1.2)
                    }
            }
        }
    }

    // MARK: - Header with decorative branch

    private var milestoneHeader: some View {
        VStack(alignment: .leading, spacing: Theme.spacingS) {
            // Decorative mini-branch connecting to tree identity
            HStack(spacing: Theme.spacingS) {
                Circle()
                    .fill(vm.milestone.isFilled ? Theme.primary : Theme.natural.opacity(0.4))
                    .frame(width: 12, height: 12)

                Rectangle()
                    .fill(Theme.natural.opacity(0.3))
                    .frame(height: 2)
                    .frame(maxWidth: 40)
            }
            .padding(.top, Theme.spacingS)

            Text(vm.milestone.title)
                .font(Theme.titleLarge)
                .foregroundStyle(Theme.textPrimary)

            Text(vm.milestone.targetDate, style: .date)
                .font(Theme.bodyFont)
                .foregroundStyle(Theme.textSecondary)

            if !vm.sortedCapsules.isEmpty {
                Text("\(vm.sortedCapsules.count) \(vm.sortedCapsules.count == 1 ? "recuerdo" : "recuerdos")")
                    .font(Theme.captionBold)
                    .foregroundStyle(Theme.primary)
                    .padding(.top, Theme.spacingXS)
            }
        }
        .padding(.top, Theme.spacingM)
    }

    // MARK: - FAB

    private var fabMenu: some View {
        Menu {
            Button {
                vm.showingPhotoPicker = true
            } label: {
                Label("Agregar foto", systemImage: "photo")
            }

            Button {
                showingNoteSheet = true
            } label: {
                Label("Escribir nota", systemImage: "note.text")
            }
        } label: {
            Image(systemName: "plus")
                .font(Theme.rounded(.title3, weight: .semibold))
                .foregroundStyle(Theme.cremaClaro)
                .frame(width: Theme.fabSize, height: Theme.fabSize)
                .background(Theme.primary)
                .clipShape(Circle())
                .shadow(color: Theme.chocolate.opacity(0.2), radius: 8, y: 4)
        }
    }

    // MARK: - Saved toast

    private var savedToast: some View {
        HStack(spacing: Theme.spacingS) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(Theme.natural)
            Text("Recuerdo guardado")
                .font(Theme.bodyBold)
                .foregroundStyle(Theme.textPrimary)
        }
        .padding(.horizontal, Theme.spacingM)
        .padding(.vertical, Theme.spacingS)
        .background(Theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: Theme.radiusL))
        .overlay {
            RoundedRectangle(cornerRadius: Theme.radiusL)
                .strokeBorder(Theme.natural.opacity(0.2), lineWidth: 1)
        }
    }

    // MARK: - Note creation sheet

    private var noteCreationSheet: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                VStack(spacing: Theme.spacingM) {
                    // Rotating inspirational placeholder
                    Text(Self.notePlaceholders.randomElement() ?? "")
                        .font(Theme.rounded(.body, weight: .medium))
                        .foregroundStyle(Theme.textSecondary.opacity(0.7))
                        .italic()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, Theme.spacingM)

                    // Paper-like text area
                    TextEditor(text: $noteText)
                        .font(Theme.bodyFont)
                        .foregroundStyle(Theme.textPrimary)
                        .scrollContentBackground(.hidden)
                        .padding(Theme.spacingM)
                        .background(
                            RoundedRectangle(cornerRadius: Theme.radiusM)
                                .fill(Theme.surface)
                                .overlay {
                                    // Subtle paper lines
                                    VStack(spacing: 28) {
                                        ForEach(0..<8, id: \.self) { _ in
                                            Rectangle()
                                                .fill(Theme.marronClaro.opacity(0.08))
                                                .frame(height: 1)
                                        }
                                    }
                                    .padding(.horizontal, Theme.spacingM)
                                    .padding(.top, Theme.spacingL)
                                }
                        )
                        .clipShape(RoundedRectangle(cornerRadius: Theme.radiusM))
                        .padding(.horizontal, Theme.spacingM)
                        .frame(minHeight: 200)

                    Spacer()
                }
                .padding(.top, Theme.spacingM)
            }
            .navigationTitle("Nota para \(vm.child.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        noteText = ""
                        showingNoteSheet = false
                    }
                    .foregroundStyle(Theme.textSecondary)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        vm.createTextCapsule(text: noteText, context: modelContext)
                        noteText = ""
                        showingNoteSheet = false
                    }
                    .foregroundStyle(Theme.primary)
                    .fontWeight(.semibold)
                    .disabled(noteText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}
