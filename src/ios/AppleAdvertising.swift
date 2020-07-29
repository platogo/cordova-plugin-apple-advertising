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
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Denied");
                case .notDetermined:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Not Determined");
                case .restricted:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Restricted");
                @unknown default:
                    pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Unknown");
            }
        }
    } else {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: idfa.uuidString);
    }

    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
  }
}
