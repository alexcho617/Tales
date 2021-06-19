//
//  ReadViewController.swift
//  TalesBeta
//
//  Created by Alex Cho on 2021/05/21.
//

import UIKit
import AVFoundation

class ReadViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate, ReadModelProtocol {
    
    
    
    
    var feedItems: NSArray = NSArray() //where urlsession stores results
    var selectedBook : ContentsModel = ContentsModel()
    
    var bookGlobal: String = "myBook"
    var idGlobal: String = "myID"
    var chapterGlobal: Int = 1
    var totalChapter = 1
    
    //@IBOutlet weak var chapterPicker: UIPickerView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
//    @IBAction func chapterPlusPressed(_ sender: UIButton) {
//        chapterGlobal = chapterGlobal + 1
//        print("chapterGlobal:", chapterGlobal)
//    }
//    
//    @IBAction func chapterMinusPressed(_ sender: UIButton) {
//        
//        chapterGlobal = chapterGlobal - 1
//        print("chapterGlobal:", chapterGlobal)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Read Loaded")
       
        // Do any additional setup after loading the view.
        
        let readModel = ReadModel()

        readModel.idGlobal = idGlobal
        
        readModel.delegate = self
        readModel.downloadItems()
        //view
        bookTitleLabel.text = bookGlobal
        chapterLabel.text = "Ch."+String(chapterGlobal)
        
        selectAudioFile()
        if !isRecordMode { //녹음모드가 아닐때.
            initplay()
            btnRecord.isEnabled = false
        }
        else { //녹음모드일때.
            initRecord()
        }
    }
    
    /*
     pickerview stuff
     */
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return totalChapter
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(row) //will simply return number
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        chapterGlobal = row
//    }
    
    /*
     book Data from server
     */
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        var chapterContents = ContentsModel()
        totalChapter = feedItems.count
        print("totalChapter:",totalChapter)

        print("Chapter:",chapterGlobal)
        chapterContents = feedItems[chapterGlobal-1] as! ContentsModel //cast from any to ContentsModel -1 for index correction
        //print(chapterContents.contents ?? "Empty")
        
        let strContents = chapterContents.contents //cast as a String
        textView.text = strContents
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        print("Finished Reading")
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     Below is Audio Recording Part
     */
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var btnRecord: UIButton!
    
    var audioPlayer : AVAudioPlayer! // audioPlayer : AVAudioPlayer 인스턴스 변수
    var audioFile : URL! // 재생할 오디오의 파일명 변수
    let MAX_VOLUME : Float = 10.0 // 최대 볼륨, 실수형 상수
    var progressTimer : Timer! // 타이머를 위한 변수
    
    var audioRecoder : AVAudioRecorder!
    var isRecordMode = false // '녹음 모드'를 나타내는 변수. 기본값은 false('재생 모드')
    
    func selectAudioFile(){
        if !isRecordMode { // 재생 모드일 때
            audioFile = Bundle.main.url(forResource: "Wiz-Khalifa-See-You-Again", withExtension: "mp3")
        } else { // 녹음 모드일 때
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    func initRecord(){
        let recordSettings = [AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
                                  AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                                  AVEncoderBitRateKey : 320000,
                                  AVNumberOfChannelsKey : 2,
                                  AVSampleRateKey : 44100.0 ] as [String : Any]
        do {
            audioRecoder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        audioRecoder.delegate = self
        audioRecoder.isMeteringEnabled =  true
        audioRecoder.prepareToRecord()
        
        audioPlayer.volume = 1.0
        setPlayButtons(false, pause: false, stop: false)
            
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
        } catch let error as NSError {
            print(" Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print(" Error-setActive : \(error)")
        }
    }
    
    func initplay(){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        
        audioPlayer.delegate = self // audioPlayer의 델리게이트는 self
        audioPlayer.prepareToPlay() // prepareToPlay() 실행
        
        setPlayButtons(true, pause: false, stop: false)
    }

    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool){
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {   //play button 눌러서 음악 실행.
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        setPlayButtons(true, pause: false, stop: false)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        setPlayButtons(true, pause: false, stop: false)
    }
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn { // 녹음 모드일 때
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            isRecordMode = true
            btnRecord.isEnabled = true
        } else { // 재생 모드일 때
            isRecordMode = false
            btnRecord.isEnabled = false
        }
        selectAudioFile() // 모드에 따라 오디오 파일을 선택함
                
        // 모드에 따라 재생 초기화 또는 녹음 초기화를 수행함
        if !isRecordMode { // 녹음 모드가 아닐 때, 즉 재생 모드일 때
            initplay()
        } else { // 녹음 모드일 때
            initRecord()
        }
    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record" { // 버튼이 'Record'일 때 녹음을 중지함
            audioRecoder.record()
            sender.setTitle("Stop", for: UIControl.State())
            
            btnPlay.isEnabled = false
        } else { // 버튼이 'Stop'일 때 녹음을 위한 초기화를 수행함
            audioRecoder.stop()
            sender.setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initplay()
        }
    }

    func convertNSTimeInterval12String(_ time:TimeInterval) -> String { //시간 불러오기
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
}
