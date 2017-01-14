//
//  PlaySoundsViewController.swift
//  PitchPefect
//
//  Created by 홍길동 on 2017. 1. 3..
//  Copyright © 2017년 TaeseonKim. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet var maximumTimeLabel: UILabel!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var player: AVAudioPlayer!
    var timer: Timer!
    
    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb }
    
    @IBAction func playSoundForButton(_ sender: UIButton){
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        stopAudio()
    }
    
    func timerString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let centiseconds = Int((Double(time) - Double(seconds)) * 100)
        return String(format:"%02i:%02i.%02i", minutes, seconds, centiseconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        do {
            try player = AVAudioPlayer(contentsOf: recordedAudioURL)
        } catch {}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        maximumTimeLabel.text = timerString(time: player.duration)
    }
}
