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
//        mediaPlayer.delegate = self
        mediaPlayer.audio.isMuted = true
        mediaPlayer.play()
    }
    
    @IBAction func snapShotButton_Clicked(_ sender: Any) {
//        if let view = (self.mediaPlayer.drawable as? UIView) {
//            let size = view.frame.size
//            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
//
//            let rec = view.frame
//            view.drawHierarchy(in: rec, afterScreenUpdates: false)
//
//            let image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//
//            if let img = image {
//                UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
//            }
//        }
//        if let image = self.mediaPlayer.lastSnapshot {
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//        }
    
        if self.mediaPlayer.hasVideoOut {
            let desPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last ?? ""
            let fileName = "\(Date().timeIntervalSince1970 * 1000).png"
            let desPathFile = desPath.appending(fileName)
            let videoSize = self.mediaPlayer.videoSize
            self.mediaPlayer.accessibilityLabel = fileName
            self.mediaPlayer.delegate = self
            self.mediaPlayer.saveVideoSnapshot(at: desPathFile, withWidth: Int32(videoSize.width), andHeight: Int32(videoSize.height))
            
            //        if let mediaPlayer = aNotification.object as? VLCMediaPlayer {
//            if let image = self.mediaPlayer.lastSnapshot {
//                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//                print("snap shot success")
//            }
            //        }
        }
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
//        startBitRateTimer()
    }
    
//    func mediaDidFinishParsing(_ aMedia: VLCMedia) {
//        print(aMedia.inputBitrate)
//        print(aMedia.demuxBitrate)
//        print(aMedia.streamOutputBitrate)
//    }
}

extension LiveVideoCollectionViewCell: VLCMediaPlayerDelegate {
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
        //        print("player state changed")
        if let mediaPlayer = aNotification.object as? VLCMediaPlayer {
            print("======== State Changed =========")
            print(mediaPlayer.media.inputBitrate)
            print(mediaPlayer.media.demuxBitrate)
            print(mediaPlayer.media.streamOutputBitrate)
            print("is playing =",mediaPlayer.isPlaying)
            print("media state = ",mediaPlayer.state.rawValue)
        }
        
    }
    
    func mediaPlayerSnapshot(_ aNotification: Notification!) {
        if let mediaPlayer = aNotification.object as? VLCMediaPlayer {
            print(mediaPlayer.accessibilityLabel)
            print(self.mediaPlayer.accessibilityLabel)
            if let accessibilityLabel = mediaPlayer.accessibilityLabel {
                if accessibilityLabel == self.mediaPlayer.accessibilityLabel {
                    if let image = mediaPlayer.lastSnapshot {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                        self.mediaPlayer.delegate = nil
                    }
                }
            }

        }
    }
}
