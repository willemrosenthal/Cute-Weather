//
//  helpers.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/4/23.
//

import Foundation

func roundToDecimal(_ value: Float, place: Float = 100 ) -> Float {
    return (round(value * place) * (1/place))
}
