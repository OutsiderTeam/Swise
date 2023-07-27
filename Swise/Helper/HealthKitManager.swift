//
//  HealthKitManager.swift
//  Swise
//
//  Created by Agfid Prasetyo on 27/07/23.
//

import Foundation
import HealthKit

/// Helper for reading and writing to HealthKit.
class HealthKitManager {
    private let healthStore = HKHealthStore()
    
    /// Requests access to all the data types the app wishes to read/write from HealthKit.
    /// On success, data is queried immediately and observer queries are set up for background
    /// delivery. This is safe to call repeatedly and should be called at least once per launch.
    func requestAccess(readHealthKitData: @escaping() -> Void) {
        let readDataTypes = dataTypesToRead()
        if HKHealthStore.isHealthDataAvailable() {
            healthStore.requestAuthorization(toShare: nil, read: readDataTypes) { success, error in
                if success {
                    readHealthKitData()
                    self.setUpBackgroundDeliveryForDataTypes(types: readDataTypes) {
                        readHealthKitData()
                    }
                } else {
                    debugPrint("error health kit: \(String(describing: error))")
                }
            }
        }
    }
}

// MARK: - Private
private extension HealthKitManager {
    /// Initiates an `HKAnchoredObjectQuery` for each type of data that the app reads and stores
    /// the result as well as the new anchor.
    
    /// Sets up the observer queries for background health data delivery.
    ///
    /// - parameter types: Set of `HKObjectType` to observe changes to.
    private func setUpBackgroundDeliveryForDataTypes(types: Set<HKObjectType>, readHealthKitData: @escaping() -> Void) {
        for type in types {
            guard let sampleType = type as? HKSampleType else { continue }
            let query = HKObserverQuery(sampleType: sampleType, predicate: nil) { HKObserverQuery, HKObserverQueryCompletionHandler, error in
                self.queryForUpdates(type: type) {
                    readHealthKitData()
                }
                HKObserverQueryCompletionHandler()
            }
            healthStore.execute(query)
            healthStore.enableBackgroundDelivery(for: type, frequency: .immediate) { success, error in
            }
        }
    }
    
    /// Initiates HK queries for new data based on the given type
    ///
    /// - parameter type: `HKObjectType` which has new data avilable.
    private func queryForUpdates(type: HKObjectType, readHealthKitData: @escaping() -> Void) {
        readHealthKitData()
    }
    
    /// Types of data that this app wishes to read from HealthKit.
    ///
    /// - returns: A set of HKObjectType.
    private func dataTypesToRead() -> Set<HKObjectType> {
        return Set(arrayLiteral:
                    HKSampleType.characteristicType(forIdentifier: .biologicalSex)!,
                    HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!,
                    HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
                    HKSampleType.quantityType (forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        )
    }
}
