import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const sendMessage = functions.firestore
  .document("Users/{EmailId}")
  .onWrite(async (change, context) => {
    // Check if document was created or updated
    if (!change.after.exists) {
      return null; // Document deleted, no need to send notification
    }

    // Get the list of tokens
    const tokensSnapshot = await db.collection("tokens").get();
    const tokens = tokensSnapshot.docs.map((doc) => doc.data().token);

    // Construct the notification payload
    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: "New detection",
        body: "Your farm has detected animal",
        click_action: "FLUTTER_NOTIFICATION_CLICK",
      },
    };
    // Send notifications to all tokens
    return fcm.sendToDevice(tokens, payload);
  });

export const sendMessage2 = functions.firestore
  .document("images/{dateTimeId}")
  .onWrite(async (change, context) => {
    // Check if document was created or updated
    if (!change.after.exists) {
      return null; // Document deleted, no need to send notification
    }

    // Get the list of tokens
    const tokensSnapshot = await db.collection("tokens").get();
    const tokens = tokensSnapshot.docs.map((doc) => doc.data().token);

    // Construct the notification payload
    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: "New detection",
        body: "Your farm has detected animal",
        click_action: "FLUTTER_NOTIFICATION_CLICK",
      },
    };
    // Send notifications to all tokens
    return fcm.sendToDevice(tokens, payload);
  });
