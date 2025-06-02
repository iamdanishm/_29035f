import 'package:_29035f/screens/auth/forgot_password/fp_email.dart';
import 'package:_29035f/screens/auth/forgot_password/fp_resend.dart';
import 'package:_29035f/screens/auth/login.dart';
import 'package:_29035f/screens/auth/otp_verification/verify_otp.dart';
import 'package:_29035f/screens/auth/register.dart';
import 'package:_29035f/screens/auth/reset_password.dart';
import 'package:_29035f/screens/splash.dart';
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
      routes: [
        GoRoute(
          path: '/fpemail',
          name: "fpemail",
          builder: (BuildContext context, GoRouterState state) {
            return FPEmailScreen();
          },
        ),
        GoRoute(
          path: '/fpresend',
          name: "fpresend",
          builder: (BuildContext context, GoRouterState state) {
            return FPResend();
          },
        ),
      ],
    ),
    GoRoute(
      path: "/splash",
      name: "splash",
      builder: (BuildContext context, GoRouterState state) => SplashScreen(),
    ),
    GoRoute(
      path: '/register',
      name: "register",
      builder: (BuildContext context, GoRouterState state) {
        return RegisterScreen();
      },
    ),
    GoRoute(
      path: "/verify_otp",
      name: "verify_otp",
      builder: (BuildContext context, GoRouterState state) {
        return VerifyOtp();
      },
    ),
    GoRoute(
      path: "/reset_password",
      name: "reset_password",
      builder: (BuildContext context, GoRouterState state) {
        return ResetPassword();
      },
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('No route defined for ${state.uri}'))),
);
