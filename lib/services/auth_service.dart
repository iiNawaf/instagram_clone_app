import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabaseClient = Supabase.instance.client;

  Future<User?> signUp(String email, String password) async {
    try {
      AuthResponse response =
          await supabaseClient.auth.signUp(email: email, password: password);
      return response.user;
    } on AuthException catch (e) {
      print("Error creating auth account: ${e.message}");
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      AuthResponse response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      return response.user;
    } catch (e) {
      print("Error logging in: $e");
      return null;
    }
  }

  Future<bool> isUserAuthenticated() async {
    return supabaseClient.auth.currentSession != null;
  }

  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }
}
