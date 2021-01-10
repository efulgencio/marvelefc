//
//  ImagenHablar.swift
//  MarveleduardofulgencioApi
//
//  Created by eduardo fulgencio on 18/5/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import UIKit
import AVFoundation

class ImagenHablar: UIView {
    
    @IBOutlet var imagenView: UIImageView!
    
    @IBOutlet var button: UIButton!
    @IBOutlet var view: UIView!
    let textoPersonaje : String = "Este texto es por defecto si no asigna ningún texto al personaje."

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ImagenHablar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
    
    @IBAction func hablarMensaje(_ sender: Any) {
        hablar(textoIn: textoPersonaje)
    }
    
    
    private func hablar(textoIn: String) {
        
        let speechsynt: AVSpeechSynthesizer = AVSpeechSynthesizer()
        let nextSpeech:AVSpeechUtterance = AVSpeechUtterance(string: textoIn)
        nextSpeech.rate = AVSpeechUtteranceDefaultSpeechRate
        
        speechsynt.speak(nextSpeech)
        
    }

}


/*
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 }
 
 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 nibSetup()
 }
 
 private func nibSetup() {
 
 view = loadViewFromNib()
 view.frame = bounds
 view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
 view.translatesAutoresizingMaskIntoConstraints = true
 
 addSubview(view)
 }
 
 
 class func instanceFromNib() -> UIView {
 return UINib(nibName: "DaysSV", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
 }
 
 func loadViewFromNib() -> UIView {
 let bundle = Bundle(for: type(of: self))
 let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
 let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
 
 return nibView
 }
 
 
 */
