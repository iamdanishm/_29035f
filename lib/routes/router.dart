import 'package:_29035f/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('No route defined for ${state.uri}'))),
);
