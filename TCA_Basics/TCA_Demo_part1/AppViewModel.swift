//
//  AppViewModel.swift
//  TCA_Demo_part1
//
//  Created by Dhanushkumar Kanagaraj on 19/09/22.
//

import Foundation

struct FactAlert: Identifiable {
    var title: String
    var id: String { self.title }
}
