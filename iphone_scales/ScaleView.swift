//
//  ScaleView.swift
//  iphone scales
//
//  Created by Nick_Romanenko on 1/13/19.
//  Copyright © 2019 Nick_Romanenko. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable //директива для отображения изменений прямо в Interface Builder
class ScaleView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext() //Получаем графический контекст, в котором мы будем рисовать
        context?.setStrokeColor(UIColor.blue.cgColor) //Задаем цвет, которым будем рисовать
        context?.setLineWidth(14.0) //Устанавливаем ширину лини, которой будем рисовать
        context?.addArc(center: CGPoint(x: 375 / 2, y: 375 / 2), radius: 375 / 2 - 14, startAngle: 0, endAngle: 2 * CGFloat(Double.pi), clockwise: true) //Задаем путь для рисования в виде дуги, центр которой расположен в центре ScaleView, радиусом равным половине ширины ScaleView минус 14 ( это чтобы вписать дугу в видимую область View), и длинной дуги — по всей окружности в 360 градусов.
        context?.strokePath() //Рисуем по заданному пути заданными параметрами
        
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        context?.addArc(center: CGPoint(x: 375 / 2, y: 375 / 2), radius: 375 / 4 - 14, startAngle: 0, endAngle: 2 * CGFloat(Double.pi), clockwise: true)
        context?.strokePath()
    }
    
}
