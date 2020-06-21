/* eslint-disable promise/no-nesting */
/* eslint-disable promise/always-return */
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.helloWorld = functions.database.ref('fires/{guanafiresId}').onWrite((snapshot, context) => {
 
  const canton = snapshot.after.val().canton;
  console.log(canton)
  const payload = {
    notification:{
        title : 'Nuevo Incendio',
        body : `Nuevo incendio agregado en ${canton}`,
        badge : '1',
        sound : 'default'
    }
};
  return admin.database().ref('tokens').once('value').then(snapshots => {
    tokens = [];
    if(snapshots.empty){
      console.log('no devices');
    }else{
    for (var token of Object.keys(snapshots.val())) {
        console.log(token)
      tokens.push(token);
    }
    

    console.log('los '+tokens)
    return admin.messaging().sendToDevice(tokens, payload).then((response=>{
        console.log('pushed them all '+response.results);
    }));
   }
  });
});