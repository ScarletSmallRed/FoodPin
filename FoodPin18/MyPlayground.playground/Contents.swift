//: Playground - noun: a place where people can play

import UIKit

enum QuickAction: String {
    case OpenFav = "OpenFav"
    case OpenDiscover = "OpenDiscover"
    case OpenAddNew = "OpenAddNew"
}

let quickAction = QuickAction.OpenFav
print(quickAction.rawValue)

let openAbout = QuickAction(rawValue: "OpenFav")
print(openAbout)

class Cat {
    var name = "CatName"
}

let cat1: Cat? = Cat()
print(cat1?.name)