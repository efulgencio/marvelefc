//
//  UtilMethods.swift
//  MarveleduardofulgencioApi
//
//  Created by eduardo fulgencio on 12/01/2021.
//  Copyright © 2021 Eduardo Fulgencio. All rights reserved.
//

import Foundation


func dateFromString(_ date: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    return dateFormatter.date(from: date)
}

func stringFromDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    return dateFormatter.string(from: date)
}

func dateFormatYYYYMMDD() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    return dateFormatter.string(from: Date())
}

func updateDateAndCounter(valores:[String]) -> [String] {
    var result = [String]()
    let fechaYYYYMMDD = dateFormatYYYYMMDD()
    var actualizado = false

    // Ya tengo la fecha
    for element in valores {
        let dateCount = element.split(separator: ":")
        if dateCount.count == 2 && dateCount[0] == fechaYYYYMMDD {
            var reproducciones = Int(dateCount[1])
            reproducciones! += 1
            result.append("\(dateCount[0]):\(String(describing: reproducciones!))")
            actualizado = true
        } else {
            // Si no actualizado mantengo el valor que estaba
            result.append(element)
        }
    }
    
    // Si no ha actualizado añado el de hoy con valor 1
    if !actualizado {
         result.append("\(fechaYYYYMMDD):1")
    }
    
    return result
}
