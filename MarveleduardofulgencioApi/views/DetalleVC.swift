//
//  DetalleVC.swift
//  MarveleduardofulgencioApi
//
//  Created by eduardo fulgencio on 8/01/2021.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import UIKit

class DetalleVC: UIViewController {

    @IBOutlet var lblitem: UILabel!
    @IBOutlet var imagenView: UIImageView!
    @IBOutlet var backgroundImage: UIImageView!
    
    var blurEffectView: UIVisualEffectView?

    lazy var basicAnimation: CABasicAnimation = {
        let animation =  CABasicAnimation(keyPath: "position.y")
        animation.fromValue = 0
        animation.toValue = imagenView.bounds.maxY
        animation.duration = 1.0
        animation.delegate = self
        return animation
    }()
    
    @IBAction func volve(_ sender: Any) {
           viewModel?.done();
    }
    
    var viewModel: DetalleVM? {
        willSet {
            viewModel?.viewDelegate = nil
        }
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        backgroundImage.image = UIImage(named: "imgpersonaje1" ) // pending default image
        if let viewModel = viewModel {
            lblitem.text = viewModel.detail?.nombre
            imagenView.load(url: URL(string: (viewModel.detail?.imagen)! + ".jpg")!)
            backgroundImage.load(url: URL(string: (viewModel.detail?.imagen)! + ".jpg")!)
            // Save Core Data
            
        } else {
            lblitem.text = ""
            imagenView.image = nil
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        animationImgCharacter()
    }
    
    private func animationImgCharacter() {
        imagenView.layer.add(basicAnimation, forKey: nil)
    }

    fileprivate func actualizarView()
    {
        if let viewModel = viewModel {
            //lblitem?.text = viewModel.detail?.name
            print(viewModel.detail?.nombre ?? "nada")
        } else {
            lblitem.text = ""
        }
    }
    
    // MARK: - CORE DATA

    private func saveCoreData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let caracter = Character(context: context)
        caracter.name = viewModel?.detail?.nombre
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    
    private func applyBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImage.addSubview(blurEffectView!)
    }

}

extension DetalleVC: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        applyBlur()
     }
}


extension DetalleVC: DetalleVMViewDelegate
{
    func valorDidChange(viewModel: DetalleVM)
    {
      actualizarView()
    }
}
