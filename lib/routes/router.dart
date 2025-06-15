import 'package:_29035f/routes/bottom_nav.dart';
import 'package:_29035f/screens/auth/forgot_password/fp_email.dart';
import 'package:_29035f/screens/auth/forgot_password/fp_resend.dart';
import 'package:_29035f/screens/auth/login.dart';
import 'package:_29035f/screens/auth/otp_verification/verify_otp.dart';
import 'package:_29035f/screens/auth/register.dart';
import 'package:_29035f/screens/auth/reset_password.dart';
import 'package:_29035f/screens/concept/concept.dart';
import 'package:_29035f/screens/contact/contact.dart';
import 'package:_29035f/screens/faq/faq.dart';
import 'package:_29035f/screens/home/home.dart';
import 'package:_29035f/screens/practical_lab/journal.dart';
import 'package:_29035f/screens/profile/profile.dart';
import 'package:_29035f/screens/splash.dart';
import 'package:_29035f/screens/subscription/subscription.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/bottom_nav',
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

    GoRoute(
      path: "/bottom_nav",
      name: "bottom_nav",
      builder: (BuildContext context, GoRouterState state) {
        return BottomNav();
      },
    ),
    GoRoute(
      path: "/home",
      name: "home",
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: "/profile",
      name: "profile",
      builder: (BuildContext context, GoRouterState state) {
        return Profile();
      },
    ),
    GoRoute(
      path: "/concept",
      name: "concept",
      builder: (BuildContext context, GoRouterState state) {
        return Concept();
      },
    ),
    GoRoute(
      path: "/subscription",
      name: "subscription",
      builder: (BuildContext context, GoRouterState state) {
        return Subscription();
      },
    ),
    GoRoute(
      path: "/faq",
      name: "faq",
      builder: (BuildContext context, GoRouterState state) {
        return Faq();
      },
    ),
    GoRoute(
      path: "/contact",
      name: "contact",
      builder: (BuildContext context, GoRouterState state) {
        return Contact();
      },
    ),
    GoRoute(
      path: "/journal",
      name: "journal",
      builder: (BuildContext context, GoRouterState state) {
        return Journal();
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          '🥺No route defined for ${state.uri}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    ),
  ),
);
