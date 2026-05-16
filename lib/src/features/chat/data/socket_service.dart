import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../core/config/app_config.dart';
import '../../../core/storage/token_storage.dart';

final socketServiceProvider = Provider<SocketService>((ref) => SocketService(ref.watch(tokenStorageProvider)));

class SocketService {
  SocketService(this._tokenStorage);
  final TokenStorage _tokenStorage;
  io.Socket? _socket;

  Future<io.Socket> connect() async {
    if (_socket?.connected == true) return _socket!;
    final token = await _tokenStorage.readAccessToken();
    _socket = io.io(
      AppConfig.socketUrl,
      io.OptionBuilder().setTransports(['websocket']).setAuth({'token': token}).disableAutoConnect().build(),
    );
    _socket!.connect();
    return _socket!;
  }

  void dispose() => _socket?.dispose();
}
