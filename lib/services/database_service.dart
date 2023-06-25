import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final supabaseClient = Supabase.instance.client;

  // -------- User table methods --------
  Future createUser(UserModel user) async {
    return await supabaseClient.from('users').insert(
        {'id': user.id, 'email': user.email, 'username': user.username});
  }

  Future updateUser(Map<String, dynamic> userObj, String uid) async {
    return await supabaseClient.from('users').update(userObj).eq('id', uid);
  }

  Future getUserById(String id) async {
    return await supabaseClient.from('users').select().eq('id', id).single();
  }

  Future getUserByUsername(String username) async {
    return await supabaseClient
        .from('users')
        .select('username')
        .ilike('username', '%$username%');
  }

  Future getUserByEmail(String email) async {
    return await supabaseClient
        .from('users')
        .select('email')
        .ilike('email', '%$email%');
  }

  // -------- End of User table methods --------

  // -------- Post table methods --------

  Future createPost(Map<String, dynamic> postObj) async {
    return await supabaseClient.from('posts').insert(postObj);
  }

  // -------- End of Post table methods --------
}
