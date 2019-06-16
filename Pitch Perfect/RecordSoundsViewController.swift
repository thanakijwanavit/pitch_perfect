//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by nic Wanavit on 6/11/19.
//  Copyright © 2019 Wanavit. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    
    //init AVFoundation variables
    var audioRecorder: AVAudioRecorder!
    
    //init IBoutlet
    @IBOutlet weak var stopRecord: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recofdingLabel: UILabel!
    
    //activate recording label and record button but disable stoprecord
    //after the view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecord.isEnabled = false
        recofdingLabel.isEnabled = true
        recordButton.isEnabled = true
    }

    func configUI(recording:Bool){
        if recording {
            recofdingLabel.text = "recording!"
            stopRecord.isEnabled = true
            recordButton.isEnabled = false
        } else{
            recordButton.isEnabled = true
            stopRecord.isEnabled = false
            recofdingLabel.text="Press to record"
        }
    }
    
    
    //main recordaudio function
    @IBAction func recordAudio(_ sender: Any) {
        //set buttons activation (and set labels)
        configUI(recording: true)

        
        
        //set dir for recording
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        //set recording file name
        let recordingName = "recordedVoice.wav"
        //append dirpath to recording name
        let pathArray = [dirPath, recordingName]
        //make full file path
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        //start session for recording
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        
        //start recording
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        print("recording started")

    }
    
    @IBAction func stopRecord(_ sender: Any) {
        configUI(recording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording" , sender: audioRecorder.url )
        }
        else {
            print("recording finished")
        }
    }
    
    //send variable with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playsoundVC = segue.destination as! PlaySoundsViewController
        let recordedAudioURL = sender as! URL
        playsoundVC.recordedAudioURL = recordedAudioURL
    }
}

