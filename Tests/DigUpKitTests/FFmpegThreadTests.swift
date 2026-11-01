#if !canImport(AVFoundation)
import Foundation
import Testing
@testable import DigUpKit

@Suite struct FFmpegThreadTests {
    @Test func limitIsHalfThePhysicalCores() {
        let cores = FFmpeg.physicalCoreCount()
        #expect(cores >= 1 && cores <= ProcessInfo.processInfo.activeProcessorCount)
        #expect(FFmpeg.threadLimit == max(1, cores / 2))
    }

    @Test(.enabled(if: FFmpeg.ffmpeg != nil)) func ffmpegTakesTheLimit() throws {
        try FFmpeg.run(FFmpeg.ffmpeg, ["-v", "error", "-nostdin", "-f", "lavfi", "-i", "testsrc=duration=1:size=64x64",
                                       "-vf", "fps=1", "-f", "null", "-"]) { _ in }
    }
}
#endif
