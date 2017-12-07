//
//  TransactionSigner.swift
//  KinSDK
//
//  Created by Kin Foundation
//  Copyright © 2017 Kin Foundation. All rights reserved.
//

import Foundation
import KinSDKPrivate

class TransactionSigner: NSObject, GethSignerProtocol {
    fileprivate weak var keyStore: GethKeyStore?
    fileprivate weak var account: GethAccount?
    fileprivate var passphrase: String
    fileprivate var networkId: NetworkId

    init(with keyStore: GethKeyStore, account: GethAccount, passphrase: String, networkId: NetworkId) {
        self.keyStore = keyStore
        self.account = account
        self.networkId = networkId
        self.passphrase = passphrase

        super.init()
    }

    // swiftlint:disable:next identifier_name
    func sign(_ p0: GethAddress!, p1: GethTransaction!) throws -> GethTransaction {
        guard
            let keyStore = keyStore,
            let account = account else {
                throw KinError.internalInconsistency

        }

        return try keyStore.signTxPassphrase(account,
                                             passphrase: passphrase,
                                             tx: p1,
                                             chainID: GethNewBigInt(Int64(networkId.asInteger())))
    }
}
