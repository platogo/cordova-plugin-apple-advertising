var exec = require('cordova/exec');

function AppleAdvertising() { }

AppleAdvertising.prototype.getIdfa = function () {
    return new Promise(function (resolve, reject) {
        exec(resolve, reject, 'AppleAdvertising', 'getIdfa');
    })
}

module.exports = new AppleAdvertising();
