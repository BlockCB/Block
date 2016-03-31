//
//  AudioPlayerView.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/2/28.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit
import Jukebox

class AudioPlayerView: UIView {
    
    var jukebox : Jukebox!
    var slider: UISlider!
    var playPauseButton: UIButton!
    var currentTimeLabel: UILabel!
    var durationLabel: UILabel!
    var indicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
        
        // configure jukebox
        self.jukebox = Jukebox(delegate: self, items: [
            JukeboxItem(URL: NSURL(string: "http://www.noiseaddicts.com/samples_1w72b820/2514.mp3")!)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews() {
        let transBlackView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 3 / 5))
        transBlackView.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
        addSubview(transBlackView)
        
        let blurView = UIToolbar(frame: CGRect(x: 0, y: CGRectGetMaxY(transBlackView.frame), width: frame.width, height: frame.height * 2 / 5))
        blurView.barStyle = .Default
//        blurView.alpha = 0.4
        addSubview(blurView)
        playPauseButton = UIButton(type: .Custom)
        playPauseButton.frame = CGRect(x: frame.width / 2 - 12 * scaleFactor, y: CGRectGetMinY(blurView.frame), width: 24*scaleFactor, height: 24*scaleFactor)
        playPauseButton.setImage(UIImage(named: "playBtn"), forState: .Normal)
        playPauseButton.addTarget(self, action: Selector("playPauseAction"), forControlEvents: .TouchUpInside)
        addSubview(playPauseButton)
        
        
        let roundBlur = UIToolbar(frame: CGRect(x: 0, y: 0, width: 40*scaleFactor, height: 40*scaleFactor))
        roundBlur.center = playPauseButton.center
        roundBlur.layer.cornerRadius = 5
        roundBlur.layer.masksToBounds = true
//        roundBlur.alpha = 0.4
        insertSubview(roundBlur, belowSubview: playPauseButton)
        
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: frame.width - 80*scaleFactor, height: 10))
        slider.center = transBlackView.center
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.setThumbImage(UIImage(named: "slidertick"), forState: .Normal)
        slider.minimumTrackTintColor = UIColor.whiteColor()
        slider.maximumTrackTintColor = UIColor(white: 1, alpha: 0.5)
        slider.addTarget(self, action: Selector("progressSliderValueChanged"), forControlEvents: .ValueChanged)
        addSubview(slider)
        
        durationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        durationLabel.font = UIFont(name: "Avenir-Light", size: 11 * scaleFactor)
        durationLabel.textColor = UIColor.whiteColor()
        durationLabel.center = CGPoint(x: CGRectGetMaxX(slider.frame) + 5 * scaleFactor + 20, y: slider.center.y)
        addSubview(durationLabel)
        
        currentTimeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        currentTimeLabel.textAlignment = .Right
        currentTimeLabel.textColor = UIColor.whiteColor()
        currentTimeLabel.font = UIFont(name: "Avenir-Light", size: 11 * scaleFactor)
        currentTimeLabel.center = CGPoint(x: CGRectGetMinX(slider.frame) - 9 * scaleFactor - 20, y: slider.center.y)
        addSubview(currentTimeLabel)
        
        indicator = UIActivityIndicatorView(frame: playPauseButton.frame)
        indicator.alpha = 0
        indicator.tintColor = UIColor(white: 0.3, alpha: 0.3)
        indicator.startAnimating()
        addSubview(indicator)
        
        resetUI()
        
    }
    
    func progressSliderValueChanged() {
        if let duration = self.jukebox.currentItem?.duration {
            self.jukebox.seekToSecond(Int(Double(self.slider.value) * duration))
        }
    }
    
    func playPauseAction() {
        switch self.jukebox.state {
        case .Ready :
            self.jukebox.playAtIndex(0)
        case .Playing :
            self.jukebox.pause()
        case .Paused :
            self.jukebox.play()
        default:
            self.jukebox.stop()
        }
    }
    
    func stopPlayer() {
        if self.jukebox.state == .Playing {
            self.jukebox.stop()
            resetUI()
        }
    }
    
    // MARK:- Helpers -
    
    func populateLabelWithTime(label : UILabel, time: Double) {
        let minutes = Int(time / 60)
        let seconds = Int(time) - minutes * 60
        
        label.text = String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
    }
    
    
    func resetUI()
    {
        self.durationLabel.text = "00:00"
        self.currentTimeLabel.text = "00:00"
        self.slider.value = 0
    }
    

}

extension AudioPlayerView: JukeboxDelegate {
    
    // MARK:- JukeboxDelegate -
    
    func jukeboxDidLoadItem(jukebox: Jukebox, item: JukeboxItem) {
        print("Jukebox did load: \(item.URL.lastPathComponent)")
    }
    
    func jukeboxPlaybackProgressDidChange(jukebox: Jukebox) {
        
        if let currentTime = jukebox.currentItem?.currentTime, let duration = jukebox.currentItem?.duration  {
            let value = Float(currentTime / duration)
            self.slider.value = value
            self.populateLabelWithTime(self.currentTimeLabel, time: currentTime)
            self.populateLabelWithTime(self.durationLabel, time: duration)
        }
    }
    
    func jukeboxStateDidChange(jukebox: Jukebox) {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.indicator.alpha = jukebox.state == .Loading ? 1 : 0
            self.playPauseButton.alpha = jukebox.state == .Loading ? 0 : 1
            self.playPauseButton.enabled = jukebox.state == .Loading ? false : true
        })
        
        if jukebox.state == .Ready {
            self.playPauseButton.setImage(UIImage(named: "playBtn"), forState: .Normal)
        } else if jukebox.state == .Loading  {
            self.playPauseButton.setImage(UIImage(named: "pauseBtn"), forState: .Normal)
        } else {
            self.playPauseButton.setImage(UIImage(named: jukebox.state == .Paused ? "playBtn" : "pauseBtn"), forState: .Normal)
        }
        
        print("Jukebox state changed to \(jukebox.state)")
    }
}
