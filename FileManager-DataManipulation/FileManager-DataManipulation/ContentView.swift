//
//  ContentView.swift
//  FileManager-DataManipulation
//
//  Created by Dipon Sutradhar on 16/5/22.
//

import SwiftUI
import UIKit
import AVFAudio
import AVFoundation

struct ContentView: View {
    

    @State var audioPlayer : AVAudioPlayer!
    
    init(){
        
        downloadFile()
        
        
    }
    
    var body: some View {
        VStack{
            
            Text("Download File")
                .padding()
                .background(Color.blue.cornerRadius(10))
                .foregroundColor(.white)
                .onTapGesture {
                    downloadFile()
                }
            Text("Play Audio")
                .padding()
                .background(Color.blue.cornerRadius(10))
                .foregroundColor(.white)
                .onTapGesture {
                    playAudio()
                }
            
        }
    }
    
    func downloadFile(){
        
        if let audioUrl = URL(string : "http://hindisongs.fusionbd.com/downloads/download.php?file=mp3/hindi/Single_Tracks/Tere_Bin-Simmba_FusionBD.Com.mp3") {
            
            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let destinationUrl = documentsDirectoryURL.appendingPathComponent("Music")

            
            if !FileManager.default.fileExists(atPath: destinationUrl.absoluteString){
                try! FileManager.default.createDirectory(at: destinationUrl, withIntermediateDirectories: true, attributes: nil)
            }
            
            let musicDestination = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Music/audio.mp3")
            
            print(musicDestination)
            
            if FileManager.default.fileExists(atPath: musicDestination.path){
                
                print("File Already Exists")
            } else {
                
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                                    guard let location = location, error == nil else { return }
                                    do {
                                        // after downloading your file you need to move it to your destination url
                                        try FileManager.default.moveItem(at: location, to: musicDestination)
                                        print("File moved to documents folder")
                                    } catch let error as NSError {
                                        print(error.localizedDescription)
                                    }
                                }).resume()
                
                
                
            }
            
            
            
        }
        
    }
    
    func playAudio(){
        
        if let audioUrl = URL(string : "http://hindisongs.fusionbd.com/downloads/download.php?file=mp3/hindi/Single_Tracks/Tere_Bin-Simmba_FusionBD.Com.mp3"){
            
            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            
            let musicDestination = documentsDirectoryURL.appendingPathComponent("Music/audio.mp3")
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: musicDestination)
                
                audioPlayer.stop()
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                
            }catch{
                print(error.localizedDescription)
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
