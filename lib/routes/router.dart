import 'package:_29035f/auth/login.dart';
import 'package:_29035f/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: "login",
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: '/register',
      name: "register",
      builder: (BuildContext context, GoRouterState state) {
        return RegisterScreen();
      },
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('No route defined for ${state.uri}'))),
);
