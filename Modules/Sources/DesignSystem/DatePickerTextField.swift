//
//  DatePickerTextField.swift
//  
//
//  Created by Mikhail Borisov on 26.03.2022.
//

import UIKit
import SwiftUI

final public class DatePickerTextField: UITextField {

    @Binding
    private var binding: String
    private let emptyTitle: String

    private var date: Date? {
        didSet {
            guard let date = date else {
                text = emptyTitle
                return
            }
            binding = date.timeIntervalSince1970.description
            text = formatter.string(from: date)
        }
    }

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.addTarget(self, action: #selector(datePickerDidSelect(_:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()

    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(dismissTextField))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        return toolBar
    }()

    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = .current
        return formatter
    }()

    public init(placeholder: String = "", binding: Binding<String>, emptyTitle: String) {
        self._binding = binding
        self.emptyTitle = emptyTitle
        super.init(frame: .zero)
        self.placeholder = placeholder
        inputView = datePicker
        inputAccessoryView = toolBar
    }

    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    @objc
    private func datePickerDidSelect(_ sender: UIDatePicker) {
        date = sender.date
    }

    @objc
    private func dismissTextField() {
        resignFirstResponder()
    }
}
