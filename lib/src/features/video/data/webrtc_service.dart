import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/api_response.dart';
import '../../chat/data/socket_service.dart';

final webRtcServiceProvider = Provider<WebRtcService>((ref) => WebRtcService(ref.watch(socketServiceProvider)));

class WebRtcService {
  WebRtcService(this._socketService);
  final SocketService _socketService;
  RTCPeerConnection? _peerConnection;
  MediaStream? localStream;

  Future<void> joinRoom(String roomId, RTCVideoRenderer local, RTCVideoRenderer remote) async {
    final socket = await _socketService.connect();
    localStream = await navigator.mediaDevices.getUserMedia({'audio': true, 'video': true});
    local.srcObject = localStream;

    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    });

    for (final track in localStream!.getTracks()) {
      await _peerConnection!.addTrack(track, localStream!);
    }

    _peerConnection!.onTrack = (event) {
      if (event.streams.isNotEmpty) remote.srcObject = event.streams.first;
    };
    _peerConnection!.onIceCandidate = (candidate) {
      socket.emit('call:ice-candidate', {'roomId': roomId, 'candidate': candidate.toMap()});
    };

    socket.emit('call:join', {'roomId': roomId});
    socket.on('call:offer', (data) async {
      final offer = asMap(asMap(data)['offer']);
      await _peerConnection!.setRemoteDescription(RTCSessionDescription(stringValue(offer['sdp']), stringValue(offer['type'], 'offer')));
      final answer = await _peerConnection!.createAnswer();
      await _peerConnection!.setLocalDescription(answer);
      socket.emit('call:answer', {'roomId': roomId, 'answer': answer.toMap()});
    });
    socket.on('call:answer', (data) {
      final answer = asMap(asMap(data)['answer']);
      _peerConnection!.setRemoteDescription(RTCSessionDescription(stringValue(answer['sdp']), stringValue(answer['type'], 'answer')));
    });
    socket.on('call:ice-candidate', (data) {
      final c = asMap(asMap(data)['candidate']);
      _peerConnection!.addCandidate(RTCIceCandidate(stringValue(c['candidate']), c['sdpMid']?.toString(), intValue(c['sdpMLineIndex'])));
    });
  }

  Future<void> startCall(String roomId) async {
    final socket = await _socketService.connect();
    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    socket.emit('call:offer', {'roomId': roomId, 'offer': offer.toMap()});
  }

  Future<void> hangUp() async {
    await localStream?.dispose();
    await _peerConnection?.close();
  }
}
