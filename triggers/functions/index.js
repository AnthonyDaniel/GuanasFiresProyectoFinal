const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

    exports.helloWorld = functions.database.ref('fires/{guanasfiresId}').onWrite((change, context)=> {
        var token= 'dOPqDj1uSgCMHaV1cQsqDF:APA91bFBOsKkYVFFc9Ki9rtQHGSNJpioQeIrSZcE67ijE7fDz5tIRKI8cC7glA88bieEAo1F6yrjud_pzN1vtovXzPtkrTUiA_XweFT8owNnEB1k6chhcdhcBZFv0owz_RjgTIRLsRTN';
        const payload = {
            notification:{
                title : 'Message from Cloud',
                body : 'This is your body',
                badge : '1',
                sound : 'default'
            }
        };
        console.log(change.after.val().email);
        return admin.messaging().sendToDevice(token,payload);
        
    });