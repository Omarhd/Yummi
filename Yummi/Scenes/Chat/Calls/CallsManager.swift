//
//  CallsManager.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 11/02/2023.
//

import CallKit

final class CallsManager: NSObject, CXProviderDelegate {
    
    let provider = CXProvider(configuration: CXProviderConfiguration())
    let callController = CXCallController()
    
    override init() {
        super.init()
        
        provider.setDelegate(self, queue: nil)
    }
    
    public func reportIncommingCalls(_ id: UUID, handle: String) {
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: handle)
        
        provider.reportNewIncomingCall(with: id, update: update) { error in
            if let error = error {
                print(String(describing: error.localizedDescription))
            } else {
                print("call reported")
            }
        }
    }
    
    public func startCall(_ id: UUID, handle: String) {
        let handle = CXHandle(type: .generic, value: handle)
        let action = CXStartCallAction(call: id, handle: handle)
        let transactions = CXTransaction(action: action)
        
        callController.request(transactions) { error in
            if let error = error {
                print(String(describing: error.localizedDescription))
            } else {
                print("call started")
            }
        }
    }
    
    // MARK: - Delegation
    
    func providerDidReset(_ provider: CXProvider) {
         
    }
}
