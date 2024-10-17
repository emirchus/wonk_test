import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wonk_app/domain/models/user_model.dart';
import 'package:wonk_app/domain/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_user;
import 'package:wonk_app/domain/services/client_service.dart';

class SupabaseUser extends UserModel {
  SupabaseUser({required super.id, required super.name, required super.email, required super.photoUrl});

  factory SupabaseUser.create(supabase_user.User user) {
    return SupabaseUser(
      id: user.id,
      name: user.userMetadata?['full_name'] ?? '',
      email: user.email!,
      photoUrl: user.userMetadata?['avatar_url'] ?? '',
    );
  }
}

@Injectable(as: AuthService)
class SupabaseAuthServiceImpl implements AuthService {
  final SupabaseClient supabase;

  @factoryMethod
  factory SupabaseAuthServiceImpl.create(ClientService clientService) {
    return SupabaseAuthServiceImpl(supabase: clientService.client);
  }

  SupabaseAuthServiceImpl({required this.supabase});

  @override
  Future<Either<Exception, UserModel>> login(String email, String password) async {
    try {
      final result = await supabase.auth.signInWithPassword(password: password, email: email);

      if (result.user == null) {
        return Left(Exception('User not found'));
      }
      return Right(SupabaseUser.create(result.user!));
    } on AuthException catch (e) {
      return Left(Exception(e.message));
    }
  }

  Future<void> _nativeGoogleSignIn() async {
    const webClientId = '626629768978-5ft7ovpj971vudjooj83mu9bp9f5knq1.apps.googleusercontent.com';
    const iosClientId = '626629768978-p971r4ho7pq91jp8agl4r44af7fncccp.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;

    if(googleAuth == null) {
      throw 'No Google Auth found.';
    }

    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Future<Either<Exception, UserModel>> loginWithGoogle() async {
    try {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        await _nativeGoogleSignIn();
      } else {
        await supabase.auth.signInWithOAuth(
          OAuthProvider.google,
          redirectTo: kIsWeb ? null : 'my.scheme://my-host', // Optionally set the redirect link to bring back the user via deeplink.
          authScreenLaunchMode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
        );
      }

      return getCurrentUser();
    } on AuthException catch (e) {
      return Left(Exception(e.message));
    }
  }

  @override
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  @override
  Future<void> recoverPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<Either<String, UserModel>> register(String email, String password) async {
    try {
      final result = await supabase.auth.signUp(email: email, password: password);

      if (result.user == null) {
        return const Left('User not found');
      }

      return Right(SupabaseUser.create(result.user!));
    } on AuthException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<Exception, UserModel>> getCurrentUser() async {
    try {
      final userResponse = await supabase.auth.getUser();

      if (userResponse.user == null) {
        return Left(Exception('User not found'));
      }

      return Right(SupabaseUser.create(userResponse.user!));
    } on AuthException catch (e) {
      return Left(Exception(e.message));
    }
  }
}
