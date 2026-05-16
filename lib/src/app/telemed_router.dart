import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/appointments/presentation/appointment_booking_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/auth/presentation/splash_screen.dart';
import '../features/chat/presentation/chat_screen.dart';
import '../features/doctors/presentation/doctor_list_screen.dart';
import '../features/doctors/presentation/doctor_profile_screen.dart';
import '../features/history/presentation/patient_history_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/notifications/presentation/notifications_screen.dart';
import '../features/payment/presentation/payment_screen.dart';
import '../features/prescriptions/presentation/prescription_viewer_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/video/presentation/video_call_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/doctors', builder: (context, state) => const DoctorListScreen()),
      GoRoute(
        path: '/doctors/:id',
        builder: (_, state) => DoctorProfileScreen(doctorId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/appointments/book/:doctorId',
        builder: (_, state) => AppointmentBookingScreen(doctorId: state.pathParameters['doctorId']!),
      ),
      GoRoute(
        path: '/chat/:conversationId',
        builder: (_, state) => ChatScreen(conversationId: state.pathParameters['conversationId']!),
      ),
      GoRoute(
        path: '/call/:roomId',
        builder: (_, state) => VideoCallScreen(roomId: state.pathParameters['roomId']!),
      ),
      GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
      GoRoute(path: '/prescriptions', builder: (context, state) => const PrescriptionViewerScreen()),
      GoRoute(path: '/payment', builder: (context, state) => const PaymentScreen()),
      GoRoute(path: '/history', builder: (context, state) => const PatientHistoryScreen()),
      GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    ],
  );
});
