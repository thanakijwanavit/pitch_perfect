//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by nic Wanavit on 6/13/19.
//  Copyright © 2019 Wanavit. All rights reserved.
//

import UIKit
import AVFoundation



class PlaySoundsViewController: UIViewController {
    
    //add all the buttons
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //add the AVaudio variables
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //add button tag to button name
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    //what to do when buttons are pressed
    @IBAction func playSoundForButton(_ sender: UIButton) {
        //activate stop button
        configureUI(.playing)
        switch(ButtonType(rawValue: sender.tag)!) {
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
    }
    
    
    //stopaudio when stop button is pressed
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        stopAudio()
    }

    
    
    //setup audio when the view is first loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    //diable stop button just before the view first appers
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
}
