//
//  CoreDataService.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 26/08/2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataService {
    static let shared = CoreDataService()
    let context = { UIApplication.shared.delegate as! AppDelegate }().persistentContainer.viewContext
    func deleteCoreDataModel () {
              let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteList")
              let delAllReqVar = NSBatchDeleteRequest(fetchRequest: request)
              do { try context.execute(delAllReqVar) }
              catch { print(error) }

    }
    func addItem(currecnyName: String, currencyCode: String, currencyFlag: String) {
        let newItem = FavoriteList(context: context)
        newItem.currencyCode = currencyCode
        newItem.currencyName = currecnyName
        newItem.createdAt = Date()
        newItem.currencyFlagUrl = currencyFlag
        do {
            try context.save()
        } catch {
        }
    }

    func deleteItem(item: FavoriteList) {
        context.delete(item)
        do {
            try context.save()
        } catch {
        }
    }
}
