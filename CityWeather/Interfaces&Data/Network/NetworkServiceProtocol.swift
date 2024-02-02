//
//  NetworkService.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import RxSwift
import RxMoya
import Moya

/* 
 Main interface for network services
 'NS' prefix shall be applied for every service that conforms to this protocl
 */
protocol NetworkServiceProtocol: AnyObject {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

extension NetworkServiceProtocol {
    
    internal func requestData<D:Decodable>(_ target: T) -> Observable<D> {
        return Observable.create { [unowned provider] observer in
            provider.rx.request(target)
                .subscribe(onSuccess: { response in
                    ResponseParser().parseAndEmmit(
                        data: response.data,
                        observer: observer)
                    
                }, onFailure: { error in
                    observer.onError(error)
                })
        }
    }
}
