//
//  RecordSoundsViewController.swift
//  Udacity App
//
//  Created by Yosemite Retail on 1/15/15.
//  Copyright (c) 2015 Yosemite Retail. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingprogress: UILabel!
    @IBOutlet weak var stopbutton: UIButton!
    @IBOutlet weak var recordbutton: UIButton!
    
    
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        //code
        recordbutton.enabled = true
        stopbutton.hidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func audiobutton(sender: UIButton) {
        recordingprogress.hidden = false
        recordbutton.enabled = false
        stopbutton.hidden = false
        
        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String  //Specific directory in which we need to save files to
        
        let currentDateTime = NSDate() //Gets the current date
        let formatter = NSDateFormatter() //Creating a var so we can format the date
        formatter.dateFormat = "ddMMyyyy-HHmmss" //We are choosing to format the date like this
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName] //Var to have path to save and name of the file
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
        //TODO Show text "recording in progress"
        recordingprogress.hidden = false
        //TODO Record the user's voice
        println("recording in progress")
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            }
        else{
            println("Recording was unsuccessful")
            recordbutton.enabled = true
            stopbutton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
             playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func stopbutton(sender: UIButton) {
        recordbutton.enabled = true
        recordingprogress.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

