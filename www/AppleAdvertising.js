var exec = require('cordova/exec');

function AppleAdvertising() { }

AppleAdvertising.prototype.getIdfa = function () {
    return new Promise(function (resolve, reject) {
        exec(resolve, reject, 'AppleAdvertising', 'getIdfa');
    })
}
    
AppleAdvertising.prototype.getTrackingAuthorizationStatus = function () {
    return new Promise(function (resolve, reject) {
        exec(resolve, reject, 'AppleAdvertising', 'getTrackingAuthorizationStatus');
    })
}


module.exports = new AppleAdvertising();
