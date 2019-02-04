//
//  ViewController.swift
//  iphone scales
//
//  Created by Nick_Romanenko on 1/13/19.
//  Copyright © 2019 Nick_Romanenko. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var scaleView: ScaleView!
    @IBOutlet weak var forceLabel: UILabel!
    @IBOutlet weak var grammLabel: UILabel!
    
    var isPlaySound = true //свойство для исключения многократного проигрывания виброотклика
    let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forceLabel.text = "0 % force"
        grammLabel.text = "0 грамм"
        
        circleView.layer.cornerRadius = 40 //закруглили углы по половине ширины
        circleView.alpha = 0.6 //прозрачность
        circleView.backgroundColor = UIColor.red
    }

    var isUpdate = true {
        didSet {
            if isUpdate == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.isUpdate = oldValue
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            circleView.center = touch.location(in: view) //устанавливаем центр круглого вью в точку касания на главном вью
            view.addSubview(circleView) //добавляем наш круглый вью на экран
        }
    }
    
    //если палец стоит или движется по экрану, то эта функция отслеживает все касания и их свойства
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first { //из всех касаний выбираем первое
            if #available(iOS 9.0, *) { //если версия ПО 9 и выше
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available { //имеет ли устройство 3д-тач
                    if touch.force >= touch.maximumPossibleForce {
                        forceLabel.text = "100%+ force"
                        grammLabel.text = "385 грамм"
                        if isPlaySound {
                            AudioServicesPlaySystemSound(1519)
                            isPlaySound = false
                        }
                    } else {
                        let force = (touch.force / touch.maximumPossibleForce) * 100
                        let grams = force * 385 / 100
                        let roundGrams = Int(grams)
                        circleView.transform = CGAffineTransform.init(scaleX: CGFloat(1 + (grams / 5) / 20), y: CGFloat(1 + (grams / 5) / 20))
                        
                        isPlaySound = true
                        
                        if isUpdate {
                            forceLabel.text = "\(Int(force))% force"
                            grammLabel.text = "\(roundGrams) грамм"
                            
                            isUpdate = false
                        }
                    }
                }
            }
        }
    }
    
    //срабатывает в момент, когда все касания на экран прекращаются
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        forceLabel.text = "0% force"
        grammLabel.text = "0 грамм"
        
        circleView.removeFromSuperview() //убрали круг
        circleView.transform = .identity
    }
}

