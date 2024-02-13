//
//  UseCase.swift
//  PixiForecast
//
//  Created by Michał Krupa on 13/02/2024.
//

import RxSwift

protocol UseCaseProtocol {
    associatedtype D
    func invoke() async throws -> Observable<D>
}
