import SwiftUI
import FamilyControls

struct SettingsView: View {

    @Environment(AppModel.self) private var appModel
    @State private var viewModel: SettingsViewModel?
    @State private var pickerSelection = FamilyActivitySelection()
    @State private var showPicker = false

    var body: some View {
        List {
            // MARK: Screen Time Authorization
            Section {
                if resolvedViewModel.isAuthorized {
                    Label("Screen Time Authorized", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .font(Typography.Token.body())
                } else {
                    Button {
                        Task { await resolvedViewModel.requestAuthorization() }
                    } label: {
                        Label("Authorize Screen Time", systemImage: "lock.shield")
                            .font(Typography.Token.controlLabel())
                    }
                }
            } header: {
                Text("Screen Time")
                    .font(Typography.Token.caption())
            }

            // MARK: Restricted Apps
            if resolvedViewModel.isAuthorized {
                Section {
                    Button {
                        pickerSelection = resolvedViewModel.selection
                        showPicker = true
                    } label: {
                        HStack {
                            Text(resolvedViewModel.hasSelection
                                 ? "Change Restricted Apps"
                                 : "Select Apps to Restrict")
                                .font(Typography.Token.controlLabel())
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    Text("Restricted Apps")
                        .font(Typography.Token.caption())
                }
            }
        }
        .familyActivityPicker(
            isPresented: $showPicker,
            selection: $pickerSelection
        )
        .onChange(of: pickerSelection) { _, newValue in
            resolvedViewModel.updateSelection(newValue)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = SettingsViewModel(appModel: appModel)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }

    private var resolvedViewModel: SettingsViewModel {
        viewModel ?? SettingsViewModel(appModel: appModel)
    }
}
