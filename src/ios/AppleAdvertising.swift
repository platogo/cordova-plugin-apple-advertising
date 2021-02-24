import AdSupport
import AppTrackingTransparency

@objc(AppleAdvertising) class AppleAdvertising : CDVPlugin {
    @objc(getIdfa:)
    func getIdfa(command: CDVInvokedUrlCommand) {
    var pluginResult: CDVPluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Unknown");

    if #available(iOS 14.0, *) {
        ATTrackingManager.requestTrackingAuthorization { status in
            if (status == .authorized) {
                let idfa = ASIdentifierManager.shared().advertisingIdentifier
                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: idfa.uuidString);
            } else {
                pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: status.rawValue);
            }

            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        }
    } else {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        if (idfa == "00000000-0000-0000-0000-000000000000") {
            pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Zeros_IDFA");
        } else {
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: idfa);
        }
        
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }
    }
    
    @objc(getTrackingAuthorizationStatus:)
    func getTrackingAuthorizationStatus(command: CDVInvokedUrlCommand) {
      var pluginResult: CDVPluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Unknown");

        if #available(iOS 14.0, *) {
            let status = ATTrackingManager.trackingAuthorizationStatus;
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: status.rawValue)
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        
      } else {
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "authorized");
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
      }
    }
}
