//
//  String+Extensions.swift
//  ToDo
//
//  Created by Lucas  Alcantara  on 20/02/25.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
