//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Sethu Sathyn on 06/09/16.
//  Copyright © 2016 Sethu Sathyan. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.enabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }



    @IBAction func recordAudio(sender: AnyObject) {
        print("Record button pressed")
        recordingLabel.text = "Recording"
        stopRecordingButton.enabled = true
        recordButton.enabled = false
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    print(filePath)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    
    try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.meteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        print("Stop recording pressed")
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View will appear called")
        stopRecordingButton.imageView?.contentMode=UIViewContentMode.ScaleAspectFit
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVRecorder finished recording")
        if (flag)
        {
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }
        else
        {
            print("saving failed")
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  
            if (segue.identifier == "stopRecording") {
                let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
                let recordedAudioURL = sender as! NSURL
                playSoundsVC.recordedAudioURL = recordedAudioURL
            }
        
    }

}

