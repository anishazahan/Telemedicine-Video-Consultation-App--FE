# MediConnect Flutter Architecture

## Stack

- Flutter Material 3
- Riverpod 3 and Flutter Hooks
- GoRouter
- Dio
- Freezed and JSON serializable
- Socket.IO client
- Flutter WebRTC
- Firebase Messaging-ready dependency
- Secure token storage
- SharedPreferences offline cache
- Syncfusion PDF viewer

## Folder structure

```text
lib/
  main.dart
  src/
    app/                 app bootstrap and routing
    core/
      config/            API/socket environment values
      localization/      lightweight en/bn/ar strings
      network/           Dio client and auth interceptor
      storage/           secure tokens and offline cache
      theme/             colors and light/dark theme
      widgets/           reusable glass cards, scaffolds, skeletons
    features/
      auth/              login, register, splash, auth repository
      doctors/           listing, filters, profile
      appointments/      booking and appointment repository
      chat/              realtime Socket.IO chat
      video/             WebRTC consultation screen
      notifications/     notification center
      payment/           payment UI shell
      history/           medical history
      prescriptions/     PDF viewer
      profile/           profile management
      settings/          theme, locale, logout
```

## Run

```bash
flutter pub get
dart run build_runner build
flutter run --dart-define=API_BASE_URL=http://localhost:5000/api/v1 --dart-define=SOCKET_URL=http://localhost:5000
```

For Android emulator, use your machine IP or `10.0.2.2` instead of `localhost`.

## Production notes

- Replace the payment screen shell with Stripe, SSLCommerz, bKash, or your chosen provider SDK.
- Configure Firebase project files before enabling push notification initialization.
- Add a TURN server to the WebRTC ICE server list for reliable mobile network calls.
- Expand localization into Flutter gen-l10n ARB files once copy stabilizes.
- Keep Freezed models at feature boundaries and map backend Mongo `_id` fields inside repositories.
