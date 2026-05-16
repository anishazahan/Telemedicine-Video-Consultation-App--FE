import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/webrtc_service.dart';

class VideoCallScreen extends HookConsumerWidget {
  const VideoCallScreen({super.key, required this.roomId});
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final local = useMemoized(RTCVideoRenderer.new);
    final remote = useMemoized(RTCVideoRenderer.new);
    final muted = useState(false);
    final cameraOff = useState(false);

    useEffect(() {
      var mounted = true;
      () async {
        await local.initialize();
        await remote.initialize();
        if (mounted) await ref.read(webRtcServiceProvider).joinRoom(roomId, local, remote);
      }();
      return () {
        mounted = false;
        ref.read(webRtcServiceProvider).hangUp();
        local.dispose();
        remote.dispose();
      };
    }, [roomId]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: RTCVideoView(remote, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover)),
          Positioned(
            top: 54,
            right: 16,
            width: 120,
            height: 170,
            child: ClipRRect(borderRadius: BorderRadius.circular(8), child: RTCVideoView(local, mirror: true, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover)),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CallButton(icon: muted.value ? Icons.mic_off : Icons.mic, onTap: () => muted.value = !muted.value),
                _CallButton(icon: Icons.call_end, color: Colors.red, onTap: () => Navigator.of(context).maybePop()),
                _CallButton(icon: cameraOff.value ? Icons.videocam_off : Icons.videocam, onTap: () => cameraOff.value = !cameraOff.value),
                _CallButton(icon: Icons.wifi_calling_3, onTap: () => ref.read(webRtcServiceProvider).startCall(roomId)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CallButton extends StatelessWidget {
  const _CallButton({required this.icon, required this.onTap, this.color});
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(backgroundColor: color ?? Colors.white24, foregroundColor: Colors.white),
      onPressed: onTap,
      icon: Icon(icon),
    );
  }
}
