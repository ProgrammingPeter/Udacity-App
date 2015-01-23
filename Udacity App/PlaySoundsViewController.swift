//
//  PlaySoundsViewController.swift
//  Udacity App
//
//  Created by Yosemite Retail on 1/16/15.
//  Copyright (c) 2015 Yosemite Retail. All rights reserved.
//  Let's see if this is working

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var MyAudioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    @IBOutlet weak var stopbutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopbutton.hidden = true
        
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            
//        var filePathURL = NSURL.fileURLWithPath(filePath)
//            
//        }
//        else{
//            println("File path was empty")
//        }
        // Do any additional setup after loading the view.
        
        MyAudioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        MyAudioPlayer.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowbutton(sender: UIButton) {
        
        stopbutton.hidden = false
        MyAudioPlayer.stop()
        MyAudioPlayer.rate = 0.5
        MyAudioPlayer.play()
    }

    @IBAction func fastbutton(sender: UIButton) {
        stopbutton.hidden = false
        MyAudioPlayer.stop()
        MyAudioPlayer.rate = 1.5
        MyAudioPlayer.play()
    }
    @IBAction func stopsound(sender: UIButton) {
        MyAudioPlayer.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
