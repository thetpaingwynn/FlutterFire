import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'

admin.initializeApp()

exports.onUserUpdated = functions.firestore.document('/users/{userId}').onUpdate(async (snap, context) => {
  const newValue = snap.after.data()
  const previousValue = snap.before.data()

  if (newValue.password !== previousValue.password) {
    await _changeUserPassword({
      uid: newValue.id,
      passwrod: newValue.passwrod
    })
  }

  if (newValue.role !== previousValue.role) {
    await _changeUserRole({
      uid: newValue.id,
      role: newValue.role
    })
  }

  if (newValue.email !== previousValue.email) {
    await _changeUserEmail({
      uid: newValue.id,
      email: newValue.email
    })
  }

  return
})

exports.onUserDeleted = functions.firestore.document('/users/{userId}').onDelete(async (snap, context) => {
  const data = snap.data()
  await _deleteUser({
    uid: data.id
  })
})

function _changeUserPassword(payload: any) {
  return admin.auth().updateUser(payload.uid, {
    password: payload.password
  })
}

function _changeUserRole(payload: any) {
  const claim: { [key: string]: boolean } = {}
  claim[payload.role] = true

  return admin.auth().setCustomUserClaims(payload.uid, claim)
}

function _changeUserEmail(payload: any) {
  return admin.auth().updateUser(payload.uid, {
    email: payload.email
  })
}

function _deleteUser(payload: any) {
  return admin.auth().deleteUser(payload.uid)
}
