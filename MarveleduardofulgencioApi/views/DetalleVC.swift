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
    
    @IBAction func volve(_ sender: Any) {
           viewModel?.done();
    }
    
    var viewModel: DetalleVM? {
        willSet {
            viewModel?.viewDelegate = nil
        }
        didSet {
            viewModel?.viewDelegate = self
          //  actualizarView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyBlur()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let viewModel = viewModel {
            lblitem.text = viewModel.detail?.nombre
            imagenView.load(url: URL(string: (viewModel.detail?.imagen)! + ".jpg")!)
        } else {
            lblitem.text = ""
            imagenView.image = nil
        }

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

    private func applyBlur() {
        backgroundImage.image = UIImage(named: "imgpersonaje1" ) // pending default image
        if let viewModel = viewModel {
            backgroundImage.load(url: URL(string: (viewModel.detail?.imagen)! + ".jpg")!)
        }
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImage.addSubview(blurEffectView!)
    }

}



extension DetalleVC: DetalleVMViewDelegate
{
    func valorDidChange(viewModel: DetalleVM)
    {
     //   actualizarView()
    }
}
