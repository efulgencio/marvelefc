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

        backgroundImage.image = UIImage(named: (viewModel?.detail?.imagen)!)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImage.addSubview(blurEffectView!)

    }

    override func viewDidAppear(_ animated: Bool) {
        if let viewModel = viewModel {
            self.lblitem.text = viewModel.detail?.nombre
            self.imagenView.image = UIImage(named: (viewModel.detail?.imagen)!)
        } else {
            self.lblitem.text = ""
            self.imagenView.image = nil
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func actualizarView()
    {
        if let viewModel = viewModel {
            //self.lblitem?.text = viewModel.detail?.name
            print(viewModel.detail?.nombre ?? "nada")
        } else {
            self.lblitem.text = ""
        }
    }
    



}



extension DetalleVC: DetalleVMViewDelegate
{
    func valorDidChange(viewModel: DetalleVM)
    {
     //   actualizarView()
    }
}
