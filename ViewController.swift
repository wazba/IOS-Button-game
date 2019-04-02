//
//  ViewController.swift
//  ButtonGame
//
//  Created by Salmijärvi on 20/12/2018.
//  Copyright © 2018 Salmijärvi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var Right:Int = 0;
    var Left:Int = 0;
    var LeftBest:Int = 0;
    var RightBest:Int = 0;
    
    var Set = 10;
    var Seconds = 10;
    var Taimer = Timer();
    var IsRunning = false;
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var TimeCount: UILabel!
    @IBOutlet weak var LeftCount: UILabel!
    @IBOutlet weak var RightCount: UILabel!
    @IBOutlet weak var LeftBestLab: UILabel!
    @IBOutlet weak var RightBestLab: UILabel!
    @IBOutlet weak var TimeController: UISegmentedControl!
    @IBOutlet weak var WinLab: UILabel!
    
    
    @IBAction func SetTime(_ sender: UISegmentedControl) {
        func SetTime(Time:Int)
        {
            Seconds = Time + 2
            Set = Time
            
        }
        
        if TimeController.selectedSegmentIndex == 0
        {
            SetTime(Time: 10)
        }
        else if TimeController.selectedSegmentIndex == 1
        {
            SetTime(Time: 20)
        }
        else if TimeController.selectedSegmentIndex == 2
        {
            SetTime(Time: 40)
        }
        else if TimeController.selectedSegmentIndex == 3
        {
            SetTime(Time: 60)
        }
        else if TimeController.selectedSegmentIndex == 4
        {
            SetTime(Time: 100)
        }
        else if TimeController.selectedSegmentIndex == 5
        {
            SetTime(Time: 120)
        }
        
        
        
    }
    @IBAction func Tap(_ sender: UIButton) {
        
        if sender.tag == 1 //LEFT
        {
            if Seconds > 0 && Seconds <= Set && IsRunning == true
            {
                Left += 1
            }
        }
        
        if sender.tag == 2 //RIGHT
        {
            if Seconds > 0 && Seconds <= Set && IsRunning == true
            {
                Right += 1
            }
        }
        
        LeftCount.text = String(Left)
        RightCount.text = String(Right)
        
        
        
    }
    
    @IBAction func Settings(_ sender: UIButton) {
        
        if sender.tag == 3 //START
        {
            if IsRunning == false
            {
                Left = 0
                Right = 0
                TimeCount.text = String("READY?")
                RunTimer()
                IsRunning = true
                
            }
        }
        
        if sender.tag == 5 //RESET LEFT
        {
            LeftBest = 0
            LeftBestLab.text = String(LeftBest)
        }
        
        if sender.tag == 4 //RESET RIGHT
        {
            RightBest = 0
            RightBestLab.text = String(RightBest)
        }
        
    }
    
    
    
    func RunTimer()
    {
        Taimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.action)), userInfo: nil, repeats: true)
    }
    
    @objc func action()
    {
        Seconds -= 1
    
        if Seconds - 1 == Set
        {
            TimeCount.text = String("SET")
        }
        else if Seconds == Set
        {
            TimeCount.text = String("GO!")
        }
        else if Seconds == 0
        {
            Taimer.invalidate()
            TimeOut()
            Seconds = Set + 2
            IsRunning = false
            TimeCount.text = String("Press start")
        }
        else
        {
            TimeCount.text = String(Seconds)
        }
        
        
    }
    
    func TimeOut()
    {
        //Check high scores
        if Right > RightBest
        {
            RightBest = Right
            RightBestLab.text = String(RightBest)
            
        }
        if Left > LeftBest
        {
            LeftBest = Left
            LeftBestLab.text = String(LeftBest)
        }
        
        if Right > Left
        {
            WinLab.backgroundColor = UIColor.orange
            WinLab.text = String("Right won!")
        }
        else if Left > Right
        {
            WinLab.backgroundColor = UIColor.green
            WinLab.text = String("Left won!")
        }
        else if Left == Right
        {
            WinLab.backgroundColor = UIColor.gray
            WinLab.text = String("-TIE-")
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        player.play()
        do
        {
            let audioPath = Bundle.main.path(forResource: "song", ofType: ".mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!)as URL)
        }
        catch
        {
            //error
        }
        
    }


}

