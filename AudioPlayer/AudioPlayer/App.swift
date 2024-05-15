//
//  Created by Dimitrios Chatzieleftheriou.
//  Copyright © 2024 Decimal. All rights reserved.
//

import AudioStreaming
import SwiftUI

@main
struct AudioPlayerApp: App {

    @State var model = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}

@Observable
class AppModel {
    @ObservationIgnored
    let audioPlayerService: AudioPlayerService
    @ObservationIgnored
    let equalizerService: EqualizerService

    init(
        audioPlayerService: AudioPlayerService = provideAudioPlayerService(),
        equalizerService: (AudioPlayerService) -> EqualizerService = provideEqualizerService
    ) {
        self.audioPlayerService = audioPlayerService
        self.equalizerService = equalizerService(audioPlayerService)
    }
}

func provideEqualizerService(playerService: AudioPlayerService) -> EqualizerService {
    EqualizerService(playerService: playerService)
}

func provideAudioPlayerService() -> AudioPlayerService {
    AudioPlayerService(
        audioPlayer: provideDefaultAudioPlayer()
    )
}

func provideDefaultAudioPlayer() -> AudioPlayer {
    AudioPlayer(
        configuration: .init(
            flushQueueOnSeek: false,
            enableLogs: true
        )
    )
}
