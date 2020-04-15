//
//  ViewController.swift
//  PlaybackView
//
//  Created by Mahmudul Hasan on 2020/4/15.
//  Copyright © 2020 Matrix Solution Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class DemoViewController: UIViewController {
    
    
    @IBOutlet weak var playerView: ERPlaybackView!
    @IBOutlet weak var playPauseButton: UIButton!
    
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    
    var isPause = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playPauseButton.setImage(UIImage.init(named: "play"), for: UIControl.State.normal)
        self.initPlayer()
    }
    
    func initPlayer() -> Void {
        let videoURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample", ofType: "mp4")!)
        let videoAsset = AVAsset(url: videoURL)
        
        playerItem = AVPlayerItem.init(asset: videoAsset)
        player = AVPlayer.init(playerItem: playerItem)
        
        player?.volume = 1.0
        player?.isMuted = false
        
        playerView.setPlayer(player)
        playerView.setVideoFillMode(AVLayerVideoGravity.resizeAspectFill.rawValue)
    }
    
    func play() -> Void {
        if (player != nil) {
            if isPause {
                player?.seek(to: (player?.currentTime())!, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
                player?.play()
            }
            else {
                player?.seek(to: CMTime.zero)
                player?.play()
            }
        }
    }
    
    func pause() -> Void {
        if (player != nil) {
            isPause = true
            player?.pause()
        }
    }
    
    func stop() -> Void {
        isPause = false
        if (player != nil) {
            player?.pause()
            
            //Deinit each component of AVPlayer
            playerView.player = nil
            player = nil
            playerItem = nil
        }
    }
    
    
    @IBAction func playPauseButtonAction(_ sender: Any) {
        if player?.rate == 1 {
            playPauseButton.setImage(UIImage.init(named: "play"), for: UIControl.State.normal)

            pause()
        }
        else{
            playPauseButton.setImage(UIImage.init(named: "pause"), for: UIControl.State.normal)

            if player == nil {
                initPlayer()
            }
            play()
        }
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        stop()
    }
}

