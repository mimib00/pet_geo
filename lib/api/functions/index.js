const functions = require("firebase-functions");
const express = require("express");
const admin = require("firebase-admin");

const app = express();
admin.initializeApp();
var db = admin.firestore();

const usersRef = db.collection("users");

// Add friend requests and send notification
app.post("/add", async (req, res) => {
  try {
    const uid = req.body.uid;
    const friendUid = req.body.friend;

    let user1Data = await usersRef.doc(uid).get();
    let user2Data = await usersRef.doc(friendUid).get();

    if (!user1Data.exists || !user2Data.exists) throw "users don't exist.";

    // add them to invited list

    await usersRef.doc(uid).set(
      {
        invited: admin.firestore.FieldValue.arrayUnion(usersRef.doc(friendUid)),
      },
      { merge: true }
    );

    await usersRef.doc(friendUid).set(
      {
        invited: admin.firestore.FieldValue.arrayUnion(usersRef.doc(uid)),
      },
      { merge: true }
    );

    // get both FCM tokens

    const tokens = [user1Data.data().token, user2Data.data().token];

    for (let i = 0; i < tokens.length; i++) {
      const payload = {
        notification: {
          title: "New Friend Request",
          body: "You have a new frind request.",
        },
      };
      await admin.messaging().sendToDevice(tokens[i], payload);
    }

    // send notifications

    res.sendStatus(200);
  } catch (error) {
    res.send(error);
  }
});

// Accept and add to freinds list
app.post("/accept", async (req, res) => {
  try {
    const uid = req.body.uid;
    const friendUid = req.body.friend;

    await usersRef.doc(uid).set(
      {
        invited: admin.firestore.FieldValue.arrayRemove(
          usersRef.doc(friendUid)
        ),
      },
      { merge: true }
    );

    await usersRef.doc(friendUid).set(
      {
        invited: admin.firestore.FieldValue.arrayRemove(usersRef.doc(uid)),
      },
      { merge: true }
    );

    await usersRef.doc(uid).set(
      {
        friends: admin.firestore.FieldValue.arrayUnion(usersRef.doc(friendUid)),
      },
      { merge: true }
    );

    await usersRef.doc(friendUid).set(
      {
        friends: admin.firestore.FieldValue.arrayUnion(usersRef.doc(uid)),
      },
      { merge: true }
    );

    res.sendStatus(200);
  } catch (error) {
    res.send(error);
  }
});

// Cancel request & Reject friend requests
app.post("/cancel", async (req, res) => {
  try {
    const uid = req.body.uid;
    const friendUid = req.body.friend;

    await usersRef.doc(uid).set(
      {
        invited: admin.firestore.FieldValue.arrayRemove(
          usersRef.doc(friendUid)
        ),
      },
      { merge: true }
    );

    await usersRef.doc(friendUid).set(
      {
        invited: admin.firestore.FieldValue.arrayRemove(usersRef.doc(uid)),
      },
      { merge: true }
    );
    res.sendStatus(200);
  } catch (error) {
    res.send(error);
  }
});

exports.friend = functions.region("europe-west2").https.onRequest(app);
