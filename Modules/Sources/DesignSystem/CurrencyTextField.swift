//
//  File.swift
//  
//
//  Created by Mikhail Borisov on 17.04.2022.
//

import SwiftUI

public struct CurrencyTextField: UIViewRepresentable {
    
    public typealias UIViewType = CurrencyUITextField
    
    private let numberFormatter: NumberFormatter
    private let currencyField: CurrencyUITextField
    
    public init(numberFormatter: NumberFormatter, value: Binding<String>) {
        self.numberFormatter = numberFormatter
        currencyField = CurrencyUITextField(formatter: numberFormatter, value:  value)
    }
    
    public func makeUIView(context: Context) -> CurrencyUITextField {
        return currencyField
    }
    
    public func updateUIView(_ uiView: CurrencyUITextField, context: Context) { }
}
