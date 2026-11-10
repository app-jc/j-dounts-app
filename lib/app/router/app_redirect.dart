import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';

String? appRedirect({
  required String location,
  required bool isAuthenticated,
  required bool isRegistrationFlow,
  required AuthFlowStep authFlowStep,
}) {
  final isAuthRoute = location.startsWith('/auth/');
  if (isRegistrationFlow && location == AppRoutes.name) {
    return authFlowStep == AuthFlowStep.name ? null : AppRoutes.otp;
  }
  if (isRegistrationFlow && location == AppRoutes.dateOfBirth) {
    return authFlowStep == AuthFlowStep.dateOfBirth ? null : AppRoutes.name;
  }
  if (location == AppRoutes.welcome) {
    if (isAuthenticated) return AppRoutes.home;
    return isRegistrationFlow ? null : AppRoutes.onboarding;
  }
  if (isAuthenticated) {
    return location == AppRoutes.onboarding || isAuthRoute
        ? AppRoutes.home
        : null;
  }
  if (location == AppRoutes.onboarding || isAuthRoute) return null;
  return AppRoutes.onboarding;
}
