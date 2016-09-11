//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Sethu Sathyn on 07/09/16.
//  Copyright © 2016 Sethu Sathyan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var darthButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recodedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Darth, Echo, Reverb }
    
    
    
    
    @IBAction func playSoundForButton(sender: UIButton){
        print("Play Sound Button pressed")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Darth:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        
        }
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton){
        print("Stop Button pressed")
        stopAudio()
    }
    
    var recordedAudioURL: NSURL!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaySoundsViewController loaded")
        setupAudio()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    

}
