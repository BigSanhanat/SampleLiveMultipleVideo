//
//  LiveVideoCollectionViewCell.swift
//  SampleLiveMultipleVideo
//
//  Created by NotSmall on 4/6/2564 BE.
//

import UIKit
import MobileVLCKit
import VideoToolbox

class LiveVideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LiveVideoCollectionViewCell"
    private var mediaPlayer = VLCMediaPlayer()
    private var bitRateTimer = Timer()
    
    @IBOutlet weak var liveVideoView: UIView!
    @IBOutlet weak var bitRateLabel: UILabel!
    
    func configure(url: String) {
//        mediaPlayer.delegate = self
        mediaPlayer.drawable = liveVideoView
        guard let liveUrl = URL(string: url) else { return }
        let media = VLCMedia(url: liveUrl)
        mediaPlayer.media = media
        mediaPlayer.media.delegate = self
        mediaPlayer.audio.isMuted = true
        mediaPlayer.play()
    }
    
    func startBitRateTimer() {
        
        bitRateTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { timer in
            print("======== bit rate =========")
            print(self.mediaPlayer.media.inputBitrate)
            print(self.mediaPlayer.media.demuxBitrate)
            print(self.mediaPlayer.media.streamOutputBitrate)
        })
        
    }
    
}

extension LiveVideoCollectionViewCell: VLCMediaDelegate {
    func mediaMetaDataDidChange(_ aMedia: VLCMedia) {
        startBitRateTimer()
    }
    
//    func mediaDidFinishParsing(_ aMedia: VLCMedia) {
//        print(aMedia.inputBitrate)
//        print(aMedia.demuxBitrate)
//        print(aMedia.streamOutputBitrate)
//    }
}
