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
    
    // Fetch request for all Character
    
    var characterList: [Character] {
       do  {
         return try  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.fetch(Character.fetchRequest())
       } catch {
         print("error pendiente de gestionar")
       }
       return [Character]()
    }
    
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
        saveCoreData()
        checkErrorImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        backgroundImage.image = UIImage(named: "imgpersonaje1" ) // pending default image
        if let viewModel = viewModel {
            lblitem.text = viewModel.detail?.nombre
            imagenView.load(url: URL(string: (viewModel.detail?.imagen)! + ".jpg")!)
            backgroundImage.load(url: URL(string: (viewModel.detail?.imagen)! + ".jpg")!)
        } else {
            lblitem.text = ""
            imagenView.image = nil
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        animationImgCharacter()
    }
    
    // Si no hay una imagen relacionada
    
    fileprivate func checkErrorImage() {
        let validation = Validation()
        
        do {
            try validation.validate(text: (viewModel?.detail!.imagen)!)
        } catch ValidationError.NotExist {
            UNService.shared.queueRequest(title: "Imagen", subTitle: "No hay imagen del personaje.")
            return
        } catch {}
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
    
    private func notInCoreData() -> Bool{
        var isNotInCoreData = false
        for character in characterList {
            if character.name == viewModel?.detail?.nombre {
                isNotInCoreData = true
            }
        }
        
        return isNotInCoreData
    }
    
    
    private func applyBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImage.addSubview(blurEffectView!)
    }
    
    private func animationImgCharacter() {
        imagenView.layer.add(basicAnimation, forKey: nil)
    }

    
    // MARK: - PRIVATE METHOD

    private func saveCoreData() {
        
        if !notInCoreData() {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let caracter = Character(context: context)
            caracter.name = viewModel?.detail?.nombre
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            UNService.shared.queueRequest(title: "Favorito", subTitle: "Este personaje se ha guardado en favoritos.")
        } else {
            UNService.shared.queueRequest(title: "Favorito", subTitle: "Este personaje ya está en favoritos.")
        }
        
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
