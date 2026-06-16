import SwiftUI

struct EditorView: View {
    @ObservedObject var viewModel: PromptEditorViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    header
                    sectionCard("Style", id: "Style") { styleSection }
                    sectionCard("Advanced Time", id: "Advanced Time") { advancedTimeSection }
                    sectionCard("Mood", id: "Mood") { moodSection }
                    sectionCard("Vocals", id: "Vocals") { vocalsSection }
                    sectionCard("Instruments", id: "Instruments") { instrumentsSection }
                    sectionCard("Production", id: "Production") { productionSection }
                    sectionCard("Effects", id: "Effects") { effectsSection }
                    sectionCard("Arrangement", id: "Arrangement") { ArrangementBuilderView(viewModel: viewModel) }
                    sectionCard("Advanced", id: "Advanced") { advancedSection }
                }
                .padding(24)
            }
            .background(AppTheme.background)
            .onChange(of: viewModel.selectedSection) { _, section in
                withAnimation(.smooth(duration: 0.24)) {
                    proxy.scrollTo(section, anchor: .top)
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Preset name", text: $viewModel.currentPreset.name)
                .textFieldStyle(.plain)
                .font(.title.weight(.semibold))
            Text("Build a structured, copy-ready music prompt with clear genre, performance, production and arrangement direction.")
                .foregroundStyle(AppTheme.secondaryText)
        }
        .padding(.bottom, 4)
    }

    private func sectionCard<Content: View>(_ title: String, id: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title3.weight(.semibold))
            content()
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.panel, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).strokeBorder(AppTheme.border, lineWidth: 1))
        .id(id)
    }

    private var styleSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Button("Randomise Prompt", action: viewModel.randomisePrompt)
                    .buttonStyle(.borderedProminent)
                Text("Creates a new preset with randomized musical, production, and arrangement choices.")
                    .font(.caption)
                    .foregroundStyle(AppTheme.secondaryText)
            }

            MultiSelectChipView(title: "Contemporary Genres", options: PromptOptions.contemporaryGenres, selection: $viewModel.currentPreset.genres)
            MultiSelectChipView(title: "World / Ethnic / Traditional Styles", options: PromptOptions.ethnicMusicStyles, selection: $viewModel.currentPreset.genres)
            HStack {
                Text("BPM")
                Slider(value: $viewModel.currentPreset.bpm, in: 40...220, step: 1)
                Text("\(Int(viewModel.currentPreset.bpm))")
                    .monospacedDigit()
                    .frame(width: 42, alignment: .trailing)
            }
            HStack {
                Picker("Root Key", selection: $viewModel.currentPreset.key) {
                    ForEach(PromptOptions.keys, id: \.self) { Text($0).tag($0) }
                }
                Picker("Mode", selection: $viewModel.currentPreset.mode) {
                    ForEach(PromptOptions.modes, id: \.self) { Text($0).tag($0) }
                }
                Picker("Time Signature", selection: $viewModel.currentPreset.timeSignature) {
                    ForEach(PromptOptions.timeSignatures, id: \.self) { Text($0).tag($0) }
                }
            }
        }
    }

    private var moodSection: some View {
        MultiSelectChipView(title: "Mood", options: PromptOptions.moods, selection: $viewModel.currentPreset.moods)
    }

    private var advancedTimeSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            MultiSelectChipView(
                title: "Additional Time Signatures",
                options: PromptOptions.timeSignatures.filter { $0 != viewModel.currentPreset.timeSignature },
                selection: $viewModel.currentPreset.alternateTimeSignatures
            )

            HStack {
                Picker("Tempo Feel", selection: $viewModel.currentPreset.tempoFeel) {
                    ForEach(PromptOptions.tempoFeels, id: \.self) { Text($0).tag($0) }
                }
                Picker("Tempo Map", selection: $viewModel.currentPreset.tempoMap) {
                    ForEach(PromptOptions.tempoMaps, id: \.self) { Text($0).tag($0) }
                }
            }

            labeledSlider("Swing Amount", leading: "straight", trailing: "heavy swing", value: $viewModel.currentPreset.swingAmount)
            labeledSlider("Tempo Humanization", leading: "grid-tight", trailing: "live drift", value: $viewModel.currentPreset.tempoHumanization)
        }
    }

    private var vocalsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Picker("Vocal Type", selection: $viewModel.currentPreset.vocalType) {
                ForEach(PromptOptions.vocalTypes, id: \.self) { Text($0).tag($0) }
            }
            MultiSelectChipView(title: "Vocal Style", options: PromptOptions.vocalStyles, selection: $viewModel.currentPreset.vocalStyles)
            labeledSlider("Vocal Distance", leading: "intimate", trailing: "distant", value: $viewModel.currentPreset.vocalDistance)
            labeledSlider("Vocal Intensity", leading: "restrained", trailing: "explosive", value: $viewModel.currentPreset.vocalIntensity)
        }
    }

    private var instrumentsSection: some View {
        checkboxGrid(PromptOptions.instruments, selection: $viewModel.currentPreset.instruments)
    }

    private var productionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Picker("Reverb", selection: $viewModel.currentPreset.reverbType) {
                ForEach(PromptOptions.reverbTypes, id: \.self) { Text($0).tag($0) }
            }
            labeledSlider("Reverb Amount", leading: "dry", trailing: "huge", value: $viewModel.currentPreset.reverbAmount)
            Picker("Delay", selection: $viewModel.currentPreset.delayType) {
                ForEach(PromptOptions.delayTypes, id: \.self) { Text($0).tag($0) }
            }
            Picker("Saturation", selection: $viewModel.currentPreset.saturationType) {
                ForEach(PromptOptions.saturationTypes, id: \.self) { Text($0).tag($0) }
            }
            labeledSlider("Stereo Width", leading: "mono", trailing: "wide", value: $viewModel.currentPreset.stereoWidth)
            Picker("Dynamics", selection: $viewModel.currentPreset.dynamics) {
                ForEach(PromptOptions.dynamicsTypes, id: \.self) { Text($0).tag($0) }
            }
        }
    }

    private var effectsSection: some View {
        checkboxGrid(PromptOptions.effects, selection: $viewModel.currentPreset.effects)
    }

    private var advancedSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Picker("Prompt Detail", selection: $viewModel.currentPreset.detailLevel) {
                ForEach(PromptDetailLevel.allCases) { level in
                    Text(level.rawValue).tag(level)
                }
            }
            .pickerStyle(.segmented)

            Toggle("Front-load important prompt phrase", isOn: $viewModel.currentPreset.frontLoadEnabled)
            TextField(
                "Front-loaded phrase",
                text: $viewModel.currentPreset.frontLoadText,
                prompt: Text("Huge cathartic chorus first, intimate whispered verse second")
            )
            .disabled(!viewModel.currentPreset.frontLoadEnabled)
            Text("When enabled, this phrase is placed at the very front of the generated prompt so the most important direction gets priority.")
                .font(.caption)
                .foregroundStyle(AppTheme.secondaryText)

            TextField("Avoid tags", text: $viewModel.currentPreset.avoidTags, prompt: Text("muddy bass, off-key vocals, spoken intro"))
            Toggle("Artist-name-safe mode", isOn: $viewModel.currentPreset.artistNameSafeMode)
            VStack(alignment: .leading, spacing: 8) {
                Text("Custom Notes")
                    .font(.headline)
                TextEditor(text: $viewModel.currentPreset.customNotes)
                    .font(.body)
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 110)
                    .padding(8)
                    .background(AppTheme.control, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Generated Negative Prompt")
                    .font(.headline)
                TextField("Negative prompt", text: $viewModel.negativePrompt)
                    .textFieldStyle(.roundedBorder)
            }
        }
    }

    private func checkboxGrid(_ options: [String], selection: Binding<[String]>) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 180), spacing: 10)], alignment: .leading, spacing: 10) {
            ForEach(options, id: \.self) { option in
                Toggle(option, isOn: Binding(
                    get: { selection.wrappedValue.contains(option) },
                    set: { isOn in
                        if isOn {
                            selection.wrappedValue.append(option)
                        } else {
                            selection.wrappedValue.removeAll { $0 == option }
                        }
                    }
                ))
                .toggleStyle(.checkbox)
            }
        }
    }

    private func labeledSlider(_ title: String, leading: String, trailing: String, value: Binding<Double>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(title)
                Spacer()
                Text("\(Int(value.wrappedValue * 100))%")
                    .foregroundStyle(AppTheme.secondaryText)
                    .monospacedDigit()
            }
            HStack {
                Text(leading)
                    .font(.caption)
                    .foregroundStyle(AppTheme.secondaryText)
                Slider(value: value, in: 0...1)
                Text(trailing)
                    .font(.caption)
                    .foregroundStyle(AppTheme.secondaryText)
            }
        }
    }
}
