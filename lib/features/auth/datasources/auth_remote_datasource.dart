import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/user_model.dart';

@injectable
class AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDatasource() 
      : _firebaseAuth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance;

  Future<UserModel> login(Map<String, dynamic> body) async {
    final email = body['email'] as String;
    final password = body['password'] as String;

    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) throw Exception('Login failed');

      // Fetch user data from Firestore
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final data = doc.data() ?? {};

      return UserModel(
        id: user.uid,
        email: user.email ?? email,
        name: data['name'] as String? ?? 'Unknown',
        phone: data['phone'] as String? ?? 'Unknown',
        token: await user.getIdToken(),
      );
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  Future<UserModel> register(Map<String, dynamic> body) async {
    final email = body['email'] as String;
    final password = body['password'] as String;
    final name = body['name'] as String;
    final phone = body['phone'] as String;

    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) throw Exception('Registration failed');

      await user.updateDisplayName(name);

      // Save additional user data to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'phone': phone,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return UserModel(
        id: user.uid,
        email: user.email ?? email,
        name: name,
        phone: phone,
        token: await user.getIdToken(),
      );
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  Future<UserModel> verifyOtp(Map<String, dynamic> body) async {
    // Note: Phone authentication needs special handling in Firebase
    // For now, we'll return a mock or throw an unimplemented error
    throw UnimplementedError('OTP verification not fully implemented with Firebase yet.');
  }
}
