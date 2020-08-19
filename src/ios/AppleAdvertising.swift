import AdSupport
import AppTrackingTransparency

@objc(AppleAdvertising) class AppleAdvertising : CDVPlugin {
    @objc(getIdfa:)
    func getIdfa(command: CDVInvokedUrlCommand) {
    var pluginResult: CDVPluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Unknown");

    if #available(iOS 14.0, *) {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
                case .authorized:
                    let idfa = ASIdentifierManager.shared().advertisingIdentifier
                    pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: idfa.uuidString);
                case .denied:
                    // permission was denied in dialog
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "denied");
                case .notDetermined:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "notDetermined");
                case .restricted:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "restricted");
                @unknown default:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "unknown");
            }
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        }
    } else {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: idfa.uuidString);
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }
    }
    
    @objc(getTrackingAuthorizationStatus:)
    func getTrackingAuthorizationStatus(command: CDVInvokedUrlCommand) {
      var pluginResult: CDVPluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Unknown");

        if #available(iOS 14.0, *) {
            let status = ATTrackingManager.trackingAuthorizationStatus;
            switch status {
                case .authorized:
                    pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "authorized");
                case .denied:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_OK, messageAs: "denied");
                case .notDetermined:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_OK, messageAs: "notDetermined");
                case .restricted:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_OK, messageAs: "restricted");
                @unknown default:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_OK, messageAs: "unknown");
            }
        
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        
      } else {
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "authorized");
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
      }
    }
}
