//
//  RepeatingPlayerView.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/3/20.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit
import Jukebox


class RepeatingPlayerView: UIView {

    var jukebox : Jukebox!
    var slider: UISlider!
    var playPauseButton: UIButton!
    var recordButton: UIButton!
    var replayButton: UIButton!
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
        
        backgroundColor = colorWithRGB(red: 251, green: 171, blue: 113)
        
        
        playPauseButton = UIButton(type: .Custom)
        playPauseButton.frame = CGRect(x: 0, y: 0, width: 25*scaleFactor, height: 25*scaleFactor)
        playPauseButton.center = CGPoint(x: self.frame.width / 2, y: self.frame.height - playPauseButton.frame.height / 2 - 12 * scaleFactor)
        playPauseButton.setImage(UIImage(named: "playBtn"), forState: .Normal)
        playPauseButton.addTarget(self, action: Selector("playPauseAction"), forControlEvents: .TouchUpInside)
        addSubview(playPauseButton)
        
        recordButton = UIButton(type: .Custom)
        recordButton.frame = playPauseButton.frame
        recordButton.center = CGPoint(x: self.frame.width / 4, y: recordButton.center.y)
        recordButton.setImage(UIImage(named: "playBtn"), forState: .Normal)
        addSubview(recordButton)
        
        replayButton = UIButton(type: .Custom)
        replayButton.frame = playPauseButton.frame
        replayButton.center = CGPoint(x: self.frame.width * 3 / 4, y: replayButton.center.y)
        replayButton.setImage(UIImage(named: "playBtn"), forState: .Normal)
        addSubview(replayButton)
        
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: frame.width - 40*scaleFactor, height: 15))
        slider.center = CGPoint(x: frame.width / 2, y: 15 * scaleFactor)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.setThumbImage(UIImage(named: "slidertick"), forState: .Normal)
        slider.setThumbImage(UIImage(named: "slidertick"), forState: .Highlighted)
        slider.setMinimumTrackImage(UIImage(named: "track"), forState: .Normal)
        slider.setMaximumTrackImage(UIImage(named: "track"), forState: .Normal)
        slider.addTarget(self, action: Selector("progressSliderValueChanged"), forControlEvents: .ValueChanged)
        addSubview(slider)
        
        durationLabel = UILabel(frame: CGRect(x: CGRectGetMaxX(slider.frame) - 50, y: CGRectGetMaxY(slider.frame), width: 50, height: 23 * scaleFactor))
        durationLabel.font = UIFont(name: "ImpactMTStd", size: 12 * scaleFactor)
        durationLabel.textAlignment = .Right
        durationLabel.textColor = UIColor.whiteColor()
        addSubview(durationLabel)
        
        currentTimeLabel = UILabel(frame: CGRect(x: CGRectGetMinX(slider.frame), y: CGRectGetMaxY(slider.frame), width: 50, height: 23 * scaleFactor))
        currentTimeLabel.textAlignment = .Left
        currentTimeLabel.textColor = UIColor.whiteColor()
        currentTimeLabel.font = UIFont(name: "Impact MT Std", size: 12 * scaleFactor)
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

extension RepeatingPlayerView: JukeboxDelegate {
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

