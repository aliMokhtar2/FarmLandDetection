const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.notifyOnPhotoAddition = functions.database.ref('/photos/{photoId}')
    .onCreate((snapshot, context) => {
        const photoData = snapshot.val();
        
        const payload = {
            notification: {
                title: 'New Photo Added!',
                body: 'Check out the latest photo.',
            }
        };

        return admin.messaging().sendToTopic('photos', payload);
    });
