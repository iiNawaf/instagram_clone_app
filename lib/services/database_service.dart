import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final supabaseClient = Supabase.instance.client;

  Future createUser(UserModel user) async {
    return await supabaseClient.from('users').insert(
        {'id': user.id, 'email': user.email, 'username': user.username});
  }

  Future updateUser(Map<String, dynamic> userObj, String uid) async {
    print("hi : $uid");
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
}
