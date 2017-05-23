//
//  ViewController.swift
//  TechPod
//
//  Created by 戸苅未紗子 on 2017/01/10.
//  Copyright © 2017年 戸苅未紗子. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var table: UITableView!
    var songNameArray = [String]()
    var fileNameArray = [String]()
    var imageNameArray = [String]()
    var audioPlayer: AVAudioPlayer!
    var musicPath: Int!
    var hantei = false
    @IBOutlet var toolbar: UIToolbar!
    var stop: UIBarButtonItem!
    var spacer: UIBarButtonItem!
    var back: UIBarButtonItem!
    var go: UIBarButtonItem!
    var cellFlagArray = [Int]()
    var index = IndexPath()
    var selectCell: UITableViewCell!
    
    //var tableView = UITableiew()
    //コードでセルを選択する方法
    //self.tableView.selectRowAtIndexPath(IndexPath.indexPathForRow(1, inSection:0), animated:false, scrollPaosition: 0)
    //google で検索！
    //selectRowAtIndexPath swift
    //self.tableView.selectRowAtIndexPath(IndexPath.indexPathForRow(0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPositionTop)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
             stop = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(self.STOP))
             spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
             back = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(self.BACK))
             go = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(self.GO) )
            toolbar.items = [back,spacer,stop,spacer,go]

        table.dataSource = self
        table.delegate = self
        songNameArray = ["カノン", "エリーゼのために", "G戦上のアリア"]
        fileNameArray = ["cannon", "elise", "aria"]
        imageNameArray = ["Pachelbel.jpg","Beethoven.jpg","Bach.jpg"]
        cellFlagArray = [0, 1, 2]
        stop.isEnabled = false
        go.isEnabled = false
       back.isEnabled = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       //セルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songNameArray.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = songNameArray[indexPath.row]
        cell?.imageView?.image = UIImage(named: imageNameArray[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("%@が選ばれた",songNameArray[indexPath.row])
        hantei = true
        if hantei {
            stop.isEnabled = true
            go.isEnabled = true
            back.isEnabled = true
            
        }

        musicPath = indexPath.row
        index = indexPath
        
        
        playMusic(musicPath: musicPath)

        
        selectCell = tableView.cellForRow(at:indexPath)
        
        
        
        // チェックマークを入れる
        selectCell?.accessoryType = .checkmark
    }
    
    
    // セルの選択が外れた時に呼び出される
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        // チェックマークを外す
        cell?.accessoryType = .none
        
        
    }

    func playMusic(musicPath: Int) {
        let audioPath = URL(fileURLWithPath: Bundle.main.path(forResource: fileNameArray[musicPath],ofType:"mp3")!)
        audioPlayer = try? AVAudioPlayer(contentsOf: audioPath)
        audioPlayer.play()
           }
    
    
    
    
    
    func STOP(sender: AnyObject) {
        
        
        
        // isPlayingプロパティがtrueであれば音源再生中
        if audioPlayer.isPlaying {
            
            
            // audioPlayerを一時停止
            audioPlayer.pause()
            stop = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(self.STOP))

            
      } else {
            
            // audioPlayerの再生
                audioPlayer.play()
            stop = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(self.STOP))

            
                
            
            
        }
        toolbar.items = [back,spacer,stop,spacer,go]
        self.index.row = musicPath


    }
    @IBAction func BACK() {
        selectCell.accessoryType = .none

        musicPath = musicPath - 1
        if musicPath < 0{
            musicPath = songNameArray.count-1
        }
        self.index.row = musicPath
        selectCellInTable(index: self.index, tableView: self.table)

        playMusic(musicPath: musicPath)
        stop = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(self.STOP))
        toolbar.items = [back,spacer,stop,spacer,go]
        self.index.row = musicPath



        
    }
    
    @IBAction func GO () {
        selectCell.accessoryType = .none
        musicPath = musicPath + 1
        
        if musicPath > songNameArray.count-1{
            musicPath = 0
        }
        self.index.row = musicPath
        selectCellInTable(index: self.index, tableView: self.table)
        playMusic(musicPath: musicPath)
        stop = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(self.STOP))
        toolbar.items = [back,spacer,stop,spacer,go]
    }
    
    func selectCellInTable(index: IndexPath, tableView: UITableView) {
            tableView.selectRow(at: index, animated: false, scrollPosition: UITableViewScrollPosition(rawValue: 0)!)
            selectCell = tableView.cellForRow(at: index)
            selectCell?.accessoryType = .checkmark
        

    }
   }

