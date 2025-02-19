//
//  String+Extensions.swift
//  ToDo-List App
//
//  Created by Lucas  Alcantara  on 19/02/25.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
