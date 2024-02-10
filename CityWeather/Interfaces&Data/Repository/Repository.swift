//
//  Repository.swift
//  CityWeather
//
//  Created by Michał Krupa on 08/02/2024.
//

import RealmSwift
import RxSwift

class Repository<T:DBObject> {
    
    typealias O = T.R
    
    var realm: Realm? = nil
    
    init() {
        do {
            realm = try Realm()
        } catch {
            // TODO: Add proper logs
            print("Error while initiating Realm")
        }
    }
    
    func retrive() -> Observable<O> {
        return Observable.create { observer in
            if let objects = self.realm?.objects(O.self),
               let object = objects.first {
                observer.onNext(object)
                observer.onCompleted()
                
            } else {
                observer.onError(DBError.noEntity)
            }
            return Disposables.create()
        }
    }
    
    func save(_ object: T) -> Observable<Void> {
        return Observable.create { observer in
            do {
                try self.realm?.write {
                    self.realm?.add(object.dbModel, update: .all)
                }
                observer.on(.next(Void()))
                observer.on(.completed)
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
