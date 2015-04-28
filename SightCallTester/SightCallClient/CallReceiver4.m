//
//  CallReceiver4.m
//  SightCallClient
//
//  Created by Ihawk on 4/28/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallReceiver4.h"
#import "RtccCallManager_Protected.h"
#import "CallsTester.h"

/*
 RECEIVER
 [;2015-04-28 12:34:58.140 SightCallClient[865:105412] <<< Round #5
 2015-04-28 12:34:58.144 SightCallClient[865:105412] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x17b97400>, Call status: Ring
 2015-04-28 12:34:58.146 SightCallClient[865:105412] >>> -[RtccCall resume]
 [fg0,0,255;I:  UCL 28/04-12:34:58:115 +0300: I/SM_MUCL SMSDK_callcreated: FFFF
 [;2015-04-28 12:34:58.144 SightCallClient[865:105411] >>> -[RtccCallManager onCallCreated:]
 [fg0,0,255;I:  UCL 28/04-12:34:58:115 +0300: I/SM_MUCL SMSDK_callcreated 0 from andrey
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:115 +0300: I/SM_MUCL ProcessMessage 0x303
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:116 +0300: I/SM_MUCL SMSDK_callstatus status: 0x2
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:116 +0300: I/SM_MUCL Msg : CALLSTATUS_RINGING
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:116 +0300: I/SM_MUCL CBCall :  6100
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:116 +0300: CORE:  Call Callback: cmd: 0x6100, callid: 0x0 Call status: 0xFFFF
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:116 +0300: CORE:  Call Callback: call created from contact andrey (type 0xFFFF)
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:116 +0300: RTCC: Searching a call for: andrey
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:116 +0300: RTCC: callCreated:contactUID: New call incoming from andrey
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:116 +0300: I/SM_MUCL CBCall :  7100
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:116 +0300: CORE:  Call Callback: cmd: 0x7100, callid: 0x0 Call status: 0x7120
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:116 +0300: CORE:  Call Callback: Ringing
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:117 +0300: RTCC: callID:contactId:currentStatus 0:-1:0x1.
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:117 +0300: RTCC: call status change
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:149 +0300: CALL: -[RtccCall resume] status 1
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:149 +0300: I/NETWORK_MUCL NET_SendCommandCallControl 7 0 255
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:157 +0300: CALL: -[RtccCall resume] 0x4100
 start - VideoProfile: 0
 start - AudioCapture: OK
 [;2015-04-28 12:34:58.480 SightCallClient[865:105410] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x17b97400>, Call status: Active
 2015-04-28 12:34:58.491 SightCallClient[865:105410] >>> -[RtccCallManager rtccCall:callStatus:] status:Active(2)
 2015-04-28 12:34:58.494 SightCallClient[865:105410] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x17b97400>, Call status: Active
 2015-04-28 12:34:58.498 SightCallClient[865:105410] >>> -[RtccCallManager onCallStarted:]
 2015-04-28 12:34:58.502 SightCallClient[865:104364] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x17b97400>, Call status: Active
 2015-04-28 12:34:58.503 SightCallClient[865:104364] >>> -[Rtcc setViewVideoIn:] view:<UIView: 0x16e28070; frame = (171 82; 117 129); autoresize = RM+BM; layer = <CALayer: 0x16e28040>>
 2015-04-28 12:34:58.505 SightCallClient[865:104364] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x17b97400>, Call status: Active
 2015-04-28 12:34:58.506 SightCallClient[865:104364] >>> -[Rtcc setViewVideoOut:] view:<UIView: 0x16e26780; frame = (39 82; 105 129); autoresize = RM+BM; layer = <CALayer: 0x16e26750>>
 [fg0,0,255;I:  UCL 28/04-12:34:58:157 +0300: I/NETWORK_MUCL NET_SendCommandCallControl 1 0 255
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:476 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:477 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:477 +0300: I/SM_MUCL ProcessMessage 0x303
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:477 +0300: I/SM_MUCL SMSDK_callstatus status: 0x3
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:477 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:477 +0300: I/SM_MUCL Msg : CALLSTATUS_ACTIVE
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:478 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:478 +0300: I/SM_MUCL ProcessMessage 0x307
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:478 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:478 +0300: I/SM_MUCL Msg : SMSDK_callsipid [f353bb3e-682c-1233-dbae-000c292a7c3a]
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:478 +0300: I/SM_MUCL ProcessMessage 0x100
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:478 +0300: I/SM_MUCL CBCall :  7100
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:479 +0300: I/SM_MUCL Msg : SMSDK_audstart 7
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:479 +0300: CORE:  Call Callback: cmd: 0x7100, callid: 0x0 Call status: 0x7130
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:479 +0300: Rtcc: Call Callback: call active
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:479 +0300: I/AUDIO_MUCL AU_SetupCodec : 7 - 320 - 16000
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:479 +0300: RTCC: callID:contactId:currentStatus 0:-1:0x2.
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:479 +0300: RTCC: call status change
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:479 +0300: I/SM_MUCL CBCall :  7300
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:479 +0300: CORE:  Call Callback: cmd: 0x7300, callid: 0x0 Call status: 0x0
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:479 +0300: I/AUDIO_MUCL OpusInit : SUCCESS
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:480 +0300: CORE: AudioCallback: cmd: 0x9101, param: 320
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:480 +0300: CORE: AudioCallback: cmd: 0x9102, param: 16000
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:480 +0300: CORE: AudioCallback: cmd: 0x9103, param: 0
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:480 +0300: I/AUDIO_MUCL AudioThread started
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:481 +0300: I/SM_MUCL ProcessMessage 0x113
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:481 +0300: I/SM_MUCL Msg : SMSDK_vidsetup 0
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:482 +0300: I/VIDEO_MUCL VID_SetupCodec: VP8 Selected
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:482 +0300: VIDEO: VideoCallback: switch video profile: 0xA102
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:482 +0300: I/SM_MUCL ProcessMessage 0x110
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:482 +0300: I/SM_MUCL Msg : SMSDK_vidstart : 3
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:482 +0300: I/VIDEO_MUCL VID_Start: starting mode: 3 [0]
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:483 +0300: I/VIDEO_MUCL Vp8Init: Codec: WebM Project VP8 Encoder v1.3.0-5271-g0337bae
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:483 +0300: I/VIDEO_MUCL Vp8Init ok
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:486 +0300: I/VIDEO_MUCL Vp8Param update:352,288,20,192000,950
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:486 +0300: VIDEO: VideoCallback: video start: 0x9203
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:487 +0300: I/VIDEO_MUCL VideoEncoderThread started
 [;[fg0,0,255;I:  UCL 28/04-12:34:58:487 +0300: I/VIDEO_MUCL VideoDecoderThread started
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:490 +0300: AUDIO: Init muclDataBufferPlay 640
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:490 +0300: AUDIO: Init muclDataBufferOut 640
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:491 +0300: AudioStart:
 Sample Rate:              16000
 Format ID:                 lpcm
 Format Flags:                 C
 Bytes per Packet:             2
 Frames per Packet:            1
 Bytes per Frame:              2
 Channels per Frame:           1
 Bits per Channel:            16
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:492 +0300: sampleRate:	16000
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:492 +0300: sampleLength:	320
 [;[fg0,0,255;I:  SDK 28/04-12:34:58:507 +0300: VIDEO: <UIView: 0x16e26780; frame = (39 82; 105 129); autoresize = RM+BM; layer = <CALayer: 0x16e26750>> Orientation UIDeviceOrientationFaceUp
 [;[fg0,0,255;[bg220,220,220;N:  SDK 28/04-12:34:58:636 +0300: AudioRoute changed: now using MicrophoneBuiltIn:Speaker - expecting 1
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:550 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL ProcessMessage 0x141
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL SMSDK_callparameters webrtc: 0
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL CallParameters:
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL webrtc		0
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL ssrc ain	7f6c3647
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL ssrc vin	6d9f9eb7
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL ssrc sin	0
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL ssrc aou	7fff0920
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL ssrc vou	f9bfa60d
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:552 +0300: I/SM_MUCL ssrc sou	fe7c3104
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:553 +0300: I/SM_MUCL payload a	97
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:553 +0300: I/SM_MUCL payload v	112
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:553 +0300: I/SM_MUCL payload s	112
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:553 +0300: I/NETWORK_MUCL NET_UpdateShowtimeMediaStatus :1 (old showtime:1)
 [;[fg0,0,255;I:  UCL 28/04-12:34:59:553 +0300: I/SM_MUCL CBCall :  7100
 [;[fg0,0,255;I:  SDK 28/04-12:34:59:553 +0300: CORE:  Call Callback: cmd: 0x7100, callid: 0x0 Call status: 0x7132
 [;[fg0,0,255;I:  SDK 28/04-12:34:59:553 +0300: Rtcc: Call Callback: Call Active And Ready
 [;[fg0,0,255;I:  SDK 28/04-12:34:59:553 +0300: RTCC: call is now fully established.
 [;[fg0,0,255;I:  UCL 28/04-12:35:00:068 +0300: I/NETWORK_MUCL NET_SendVideoPLI: Asking for video KF
 [;[fg0,0,255;I:  UCL 28/04-12:35:05:334 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:35:05:335 +0300: I/SM_MUCL ProcessMessage 0x131
 [;[fg0,0,255;I:  UCL 28/04-12:35:05:335 +0300: I/SM_MUCL Msg : SMSDK_getmediastats
 [;[fg0,0,255;I:  UCL 28/04-12:35:05:336 +0300: I/NETWORK_MUCL NET_SendMediaStats
 [;[fg0,0,255;I:  UCL 28/04-12:35:09:589 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:35:09:590 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:35:09:590 +0300: I/SM_MUCL ProcessMessage 0x101
 [;[fg0,0,255;I:  UCL 28/04-12:35:09:590 +0300: I/SM_MUCL Msg : SMSDK_audstop
 [;[fg0,0,255;I:  UCL 28/04-12:35:09:590 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  SDK 28/04-12:35:09:590 +0300: CORE: AudioCallback: cmd: 0x9104, param: 0
 [;[fg0,0,255;I:  SDK 28/04-12:35:09:591 +0300: AUDIO: Stopping the graph.
 [;[fg0,0,255;I:  SDK 28/04-12:35:09:591 +0300: AUDIO: Audio Unit Graph stopped.
 [;[fg0,0,255;I:  UCL 28/04-12:35:19:593 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:35:29:595 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:35:39:597 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:35:49:599 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:35:50:031 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:35:50:031 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:36:00:033 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:36:10:035 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:36:20:038 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:36:30:040 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:36:40:042 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:36:50:044 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:37:00:046 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:37:10:049 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:37:15:641 +0300: I/NETWORK_MUCL NetworkThread : PING_FROM_MODP
 [;[fg0,0,255;I:  UCL 28/04-12:37:15:641 +0300: I/NETWORK_MUCL NET_SendPing 1
 [;[fg0,0,255;I:  UCL 28/04-12:37:25:643 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:37:35:646 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:37:45:648 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:37:53:634 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:38:03:636 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:38:13:639 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:38:23:641 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:38:33:644 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:38:43:645 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:38:50:467 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:39:00:470 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:39:10:474 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:39:20:477 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:39:25:180 +0300: I/NETWORK_MUCL NetworkThread : PING_FROM_MODP
 [;[fg0,0,255;I:  UCL 28/04-12:39:25:181 +0300: I/NETWORK_MUCL NET_SendPing 1
 [;[fg0,0,255;I:  UCL 28/04-12:39:31:117 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:39:31:117 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:39:41:120 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:39:51:123 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:40:01:125 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:40:11:128 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:40:21:130 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:40:31:132 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:40:41:134 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:40:51:136 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:41:01:139 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:41:11:141 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:41:21:155 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:41:31:158 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:41:33:592 +0300: I/NETWORK_MUCL NetworkThread : PING_FROM_MODP
 
 
 
 CALLER
 [;2015-04-28 12:36:55.388 SightCallClient[286:24270] <<< Round #5
 2015-04-28 12:36:55.389 SightCallClient[286:24270] >>> >>> Rtcc status: Authenticated, Active Call: (null), Call status: Proceeding
 2015-04-28 12:36:55.390 SightCallClient[286:24270] >>> -[Rtcc createCall:andSetDisplayName:withVideo:] contactID: andreyDiet, name: andreyDiet, withVideo:1
 [fg0,0,255;I:  SDK 28/04-12:36:55:391 +0300: RTCC: calling andreyDiet
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:394 +0300: I/MUCL_MUCL int MUCL_CallCreate(uint16_t, const char *): 0xFFFF andreyDiet
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:395 +0300: I/NETWORK_MUCL NET_SendCommandCallCreate 65535 (0xFFFF) andreyDiet
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:704 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:704 +0300: I/SM_MUCL ProcessMessage 0x3001
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:704 +0300: I/SM_MUCL StateMachine : ProcessMessage_SDK : MUCL_TIMEOUT
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:704 +0300: I/SM_MUCL Msg : MUCL_TIMEOUT
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:816 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;2015-04-28 12:36:55.826 SightCallClient[286:25444] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Proceeding
 2015-04-28 12:36:55.829 SightCallClient[286:25444] >>> -[RtccCallManager rtccCallCreated:] call:<RtccCall: 0x14f88d600>
 [fg0,0,255;I:  UCL 28/04-12:36:55:817 +0300: I/SM_MUCL ProcessMessage 0x301
 [;2015-04-28 12:36:55.832 SightCallClient[286:25445] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Proceeding
 2015-04-28 12:36:55.836 SightCallClient[286:25445] >>> -[RtccCallManager rtccCall:callStatus:] status:Proceeding(0)
 2015-04-28 12:36:55.838 SightCallClient[286:25445] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Proceeding
 2015-04-28 12:36:55.842 SightCallClient[286:25445] >>> -[RtccCallManager onCallProceeding:]
 2015-04-28 12:36:55.832 SightCallClient[286:25444] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Proceeding
 2015-04-28 12:36:55.845 SightCallClient[286:25444] >>> -[RtccCallManager onCallCreated:]
 [fg0,0,255;I:  UCL 28/04-12:36:55:817 +0300: I/SM_MUCL SMSDK_callcreated: FFFF
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:817 +0300: I/SM_MUCL SMSDK_callcreated 0 from andreyDiet
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:817 +0300: I/SM_MUCL CBCall :  6100
 [;[fg0,0,255;I:  SDK 28/04-12:36:55:817 +0300: CORE:  Call Callback: cmd: 0x6100, callid: 0x0 Call status: 0xFFFF
 [;[fg0,0,255;I:  SDK 28/04-12:36:55:817 +0300: CORE:  Call Callback: call created from contact andreyDiet (type 0xFFFF)
 [;[fg0,0,255;I:  SDK 28/04-12:36:55:817 +0300: RTCC: Searching a call for: andreyDiet
 [;[fg0,0,255;I:  SDK 28/04-12:36:55:817 +0300: RTCC: callCreated:contactUID: Calling andreyDiet
 [;[fg0,0,255;I:  SDK 28/04-12:36:55:817 +0300: CALL: -[RtccCall resume] status 0
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:817 +0300: I/NETWORK_MUCL NET_SendCommandCallControl 7 0 255
 [;[fg0,0,255;I:  SDK 28/04-12:36:55:819 +0300: CALL: -[RtccCall resume] 0x4100
 start - VideoProfile: 1
 start - AudioCapture: OK
 [;[fg0,0,255;I:  UCL 28/04-12:36:55:819 +0300: I/NETWORK_MUCL NET_SendCommandCallControl 1 0 255
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:138 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:138 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:138 +0300: I/SM_MUCL ProcessMessage 0x3003
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:138 +0300: I/SM_MUCL Msg : MUCL_CMDERROR : cmd 302
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:138 +0300: I/SM_MUCL ProcessMessage 0x303
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:138 +0300: I/SM_MUCL SMSDK_callstatus status: 0x5
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:139 +0300: I/SM_MUCL Msg : CALLSTATUS_PROCEEDING
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:139 +0300: I/SM_MUCL CBCall :  7100
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:139 +0300: CORE:  Call Callback: cmd: 0x7100, callid: 0x0 Call status: 0x7150
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:760 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:760 +0300: I/SM_MUCL ProcessMessage 0x303
 [;2015-04-28 12:36:56.770 SightCallClient[286:25413] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Active
 [fg0,0,255;I:  UCL 28/04-12:36:56:760 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;2015-04-28 12:36:56.792 SightCallClient[286:25413] >>> -[RtccCallManager rtccCall:callStatus:] status:Active(2)
 [fg0,0,255;I:  UCL 28/04-12:36:56:760 +0300: I/SM_MUCL SMSDK_callstatus status: 0x3
 [;2015-04-28 12:36:56.809 SightCallClient[286:25413] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Active
 [fg0,0,255;I:  UCL 28/04-12:36:56:761 +0300: I/SM_MUCL Msg : CALLSTATUS_ACTIVE
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:761 +0300: I/SM_MUCL ProcessMessage 0x307
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:761 +0300: I/SM_MUCL Msg : SMSDK_callsipid [f353bb3e-682c-1233-dbae-000c292a7c3a]
 [;2015-04-28 12:36:56.852 SightCallClient[286:25413] >>> -[RtccCallManager onCallStarted:]
 2015-04-28 12:36:56.861 SightCallClient[286:24270] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Active
 2015-04-28 12:36:56.862 SightCallClient[286:24270] >>> -[Rtcc setViewVideoIn:] view:<UIView: 0x170189b30; frame = (171 154; 117 129); autoresize = RM+BM; layer = <CALayer: 0x1702250e0>>
 2015-04-28 12:36:56.862 SightCallClient[286:24270] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Active
 2015-04-28 12:36:56.862 SightCallClient[286:24270] >>> -[Rtcc setViewVideoOut:] view:<UIView: 0x1701897f0; frame = (39 154; 105 129); autoresize = RM+BM; layer = <CALayer: 0x1702253c0>>
 [fg0,0,255;I:  UCL 28/04-12:36:56:761 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:761 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:761 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:762 +0300: I/SM_MUCL CBCall :  7100
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:762 +0300: CORE:  Call Callback: cmd: 0x7100, callid: 0x0 Call status: 0x7130
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:762 +0300: Rtcc: Call Callback: call active
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:762 +0300: RTCC: callID:contactId:currentStatus 0:-1:0x2.
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:762 +0300: RTCC: call status change
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:762 +0300: I/SM_MUCL CBCall :  7300
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:762 +0300: CORE:  Call Callback: cmd: 0x7300, callid: 0x0 Call status: 0x0
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:762 +0300: I/SM_MUCL ProcessMessage 0x100
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:762 +0300: I/SM_MUCL Msg : SMSDK_audstart 7
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:763 +0300: I/AUDIO_MUCL AU_SetupCodec : 7 - 320 - 16000
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:763 +0300: I/AUDIO_MUCL OpusInit : SUCCESS
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:763 +0300: CORE: AudioCallback: cmd: 0x9101, param: 320
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:763 +0300: CORE: AudioCallback: cmd: 0x9102, param: 16000
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:763 +0300: CORE: AudioCallback: cmd: 0x9103, param: 0
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:763 +0300: I/SM_MUCL ProcessMessage 0x113
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:764 +0300: I/SM_MUCL Msg : SMSDK_vidsetup 0
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:764 +0300: I/VIDEO_MUCL VID_SetupCodec: VP8 Selected
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:765 +0300: VIDEO: VideoCallback: switch video profile: 0xA102
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:765 +0300: I/SM_MUCL ProcessMessage 0x110
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:765 +0300: I/SM_MUCL Msg : SMSDK_vidstart : 3
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:765 +0300: I/VIDEO_MUCL VID_Start: starting mode: 3 [0]
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:765 +0300: I/VIDEO_MUCL Vp8Init: Codec: WebM Project VP8 Encoder v1.3.0-5271-g0337bae
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:765 +0300: I/VIDEO_MUCL Vp8Init ok
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:768 +0300: I/VIDEO_MUCL Vp8Param update:352,288,20,192000,950
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:768 +0300: VIDEO: VideoCallback: video start: 0x9203
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:768 +0300: I/AUDIO_MUCL AudioThread started
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:769 +0300: I/VIDEO_MUCL VideoEncoderThread started
 [;[fg0,0,255;I:  UCL 28/04-12:36:56:769 +0300: I/VIDEO_MUCL VideoDecoderThread started
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:779 +0300: AUDIO: Init muclDataBufferPlay 640
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:779 +0300: AUDIO: Init muclDataBufferOut 640
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:781 +0300: AudioStart:
 Sample Rate:              16000
 Format ID:                 lpcm
 Format Flags:                 C
 Bytes per Packet:             2
 Frames per Packet:            1
 Bytes per Frame:              2
 Channels per Frame:           1
 Bits per Channel:            16
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:781 +0300: sampleRate:	16000
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:781 +0300: sampleLength:	320
 [;[fg0,0,255;I:  SDK 28/04-12:36:56:863 +0300: VIDEO: <UIView: 0x1701897f0; frame = (39 154; 105 129); autoresize = RM+BM; layer = <CALayer: 0x1702253c0>> Orientation UIDeviceOrientationFaceUp
 [;[fg0,0,255;[bg220,220,220;N:  SDK 28/04-12:36:57:121 +0300: AudioRoute changed: now using MicrophoneBuiltIn:Receiver - expecting 1
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:261 +0300: AUDIO: startAudio Started Audio Unit Graph
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:261 +0300: CORE: VideoStart 0x9203
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:261 +0300: CALL: ReceivingVideo: YES
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:261 +0300: VIDEOIN: start fetching
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:267 +0300: CALL: SendingVideo: 0x1701897f0 (YES)
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:267 +0300: VIDEO: <UIView: 0x1701897f0; frame = (39 154; 105 129); autoresize = RM+BM; layer = <CALayer: 0x1702253c0>> Orientation UIDeviceOrientationFaceUp
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:268 +0300: VIDEO: out status state_stopped
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:285 +0300: VIDEO: In starting to fetch video
 [;[fg0,0,255;[bg220,220,220;N:  SDK 28/04-12:36:57:304 +0300: AudioRoute changed: now using MicrophoneBuiltIn:Speaker - expecting 1
 [;[fg0,0,255;[bg220,220,220;N:  SDK 28/04-12:36:57:314 +0300: AudioRoute changed: now using MicrophoneBuiltIn:Speaker - expecting 1
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:745 +0300: Changing the video state from state_stopped to state_active
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:783 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL ProcessMessage 0x141
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL SMSDK_callparameters webrtc: 0
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL CallParameters:
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL webrtc		0
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL ssrc ain	7fff0920
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL ssrc vin	f9bfa60d
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL ssrc sin	0
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL ssrc aou	7f6c3647
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL ssrc vou	6d9f9eb7
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL ssrc sou	fff3f07a
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:784 +0300: I/SM_MUCL payload a	97
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:785 +0300: I/SM_MUCL payload v	112
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:785 +0300: I/SM_MUCL payload s	112
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:785 +0300: I/NETWORK_MUCL NET_UpdateShowtimeMediaStatus :1 (old showtime:1)
 [;[fg0,0,255;I:  UCL 28/04-12:36:57:785 +0300: I/SM_MUCL CBCall :  7100
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:785 +0300: CORE:  Call Callback: cmd: 0x7100, callid: 0x0 Call status: 0x7132
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:785 +0300: Rtcc: Call Callback: Call Active And Ready
 [;[fg0,0,255;I:  SDK 28/04-12:36:57:785 +0300: RTCC: call is now fully established.
 [;[fg0,0,255;I:  UCL 28/04-12:36:58:002 +0300: I/VIDEO_MUCL VID_Encode parameter changed:352 288 [0 0]
 [;[fg0,0,255;I:  UCL 28/04-12:36:58:003 +0300: I/VIDEO_MUCL Vp8Param update:352,288,20,192000,950
 [;[fg255,127,0;[bg220,220,220;W:  UCL 28/04-12:36:58:005 +0300: W/VIDEO_MUCL Vp8Encode : FORCEKF 2,1
 [;[fg0,0,255;I:  UCL 28/04-12:36:58:098 +0300: I/VIDEO_MUCL VID_Encode parameter changed:288 352 [352 288]
 [;[fg0,0,255;I:  UCL 28/04-12:36:58:101 +0300: I/VIDEO_MUCL Vp8Param update:288,352,20,192000,950
 [;[fg255,127,0;[bg220,220,220;W:  UCL 28/04-12:36:58:101 +0300: W/VIDEO_MUCL Vp8Encode : FORCEKF 2,0
 [;[fg255,127,0;[bg220,220,220;W:  UCL 28/04-12:36:58:130 +0300: W/VIDEO_MUCL Vp8Encode : FORCEKF 1,0
 [;[fg0,0,255;I:  UCL 28/04-12:36:58:595 +0300: I/NETWORK_MUCL WeemoBundleDeal PLI/FIR from WebRTC
 [;[fg255,127,0;[bg220,220,220;W:  UCL 28/04-12:36:58:597 +0300: W/VIDEO_MUCL Vp8Encode : FORCEKF 0,1
 [;[fg0,0,255;I:  UCL 28/04-12:37:06:794 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:37:06:794 +0300: I/SM_MUCL ProcessMessage 0x131
 [;[fg0,0,255;I:  UCL 28/04-12:37:06:794 +0300: I/SM_MUCL Msg : SMSDK_getmediastats
 [;[fg0,0,255;I:  UCL 28/04-12:37:06:794 +0300: I/NETWORK_MUCL NET_SendMediaStats
 [;2015-04-28 12:37:06.864 SightCallClient[286:24270] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Active
 2015-04-28 12:37:06.864 SightCallClient[286:24270] >>> -[RtccCall hangup]
 2015-04-28 12:37:06.865 SightCallClient[286:24270] >>> >>> Rtcc status: Authenticated, Active Call: <RtccCall: 0x14f88d600>, Call status: Active
 2015-04-28 12:37:06.865 SightCallClient[286:24270] >>> -[RtccCallManager onHangupCall:]
 [fg0,0,255;I:  UCL 28/04-12:37:06:865 +0300: I/NETWORK_MUCL NET_SendCommandCallControl 2 0 0
 [;[fg0,0,255;I:  UCL 28/04-12:37:06:866 +0300: I/SM_MUCL ProcessMessage 0x303
 [;[fg0,0,255;I:  UCL 28/04-12:37:06:866 +0300: I/SM_MUCL SMSDK_callstatus status: 0x14
 [;[fg0,0,255;I:  UCL 28/04-12:37:06:866 +0300: I/SM_MUCL Msg : local emission CALLSTATUS_ENDED
 [;[fg0,0,255;I:  SDK 28/04-12:37:06:866 +0300: CORE: AudioCallback: cmd: 0x9104, param: 0
 [;[fg0,0,255;I:  SDK 28/04-12:37:06:866 +0300: AUDIO: Stopping the graph.
 [;[fg0,0,255;I:  SDK 28/04-12:37:06:884 +0300: AUDIO: Audio Unit Graph stopped.
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:011 +0300: AUDIO: Audio Unit Graph disposed of.
 [;[fg0,0,255;[bg220,220,220;N:  SDK 28/04-12:37:07:030 +0300: AUDIO: AVAudioSession setActive:NO OK'd
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:030 +0300: I/AUDIO_MUCL AudioThread stopped
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:042 +0300: VIDEO: VideoCallback: video stop: 0x9203
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:042 +0300: CORE: VideoStop 0x9203
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:042 +0300: I/VIDEO_MUCL VID_Stop: mode : 3 VideoParam.Mode:3
 [;2015-04-28 12:37:07.072 SightCallClient[286:25443] >>> >>> Rtcc status: Authenticated, Active Call: (null), Call status: Proceeding
 [fg0,0,255;I:  SDK 28/04-12:37:07:043 +0300: CALL: ReceivingVideo: NO
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:043 +0300: I/VIDEO_MUCL VID_Stop: stopping threads
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:043 +0300: CALL: SendingVideo: 0x1701897f0 (NO)
 [;2015-04-28 12:37:07.089 SightCallClient[286:25443] >>> -[RtccCallManager rtccCall:callStatus:] status:Ended(3)
 2015-04-28 12:37:07.099 SightCallClient[286:25443] >>> >>> Rtcc status: Authenticated, Active Call: (null), Call status: Proceeding
 2015-04-28 12:37:07.100 SightCallClient[286:25443] >>> -[RtccCallManager rtccCallEnded:withReason:] reason:0
 2015-04-28 12:37:07.101 SightCallClient[286:25443] >>> >>> Rtcc status: Authenticated, Active Call: (null), Call status: Proceeding
 2015-04-28 12:37:07.101 SightCallClient[286:25443] >>> -[RtccCallManager onCallFinished:]
 [fg0,0,255;I:  UCL 28/04-12:37:07:043 +0300: I/VIDEO_MUCL VideoEncoderThread stopped
 [;2015-04-28 12:37:07.105 SightCallClient[286:25443] <<< Round #5 STAT:
 2015-04-28 12:37:07.106 SightCallClient[286:25443] Errors: 0, losts: 0
 [fg0,0,255;I:  SDK 28/04-12:37:07:044 +0300: VIDEO: In stopping to fetch video
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:045 +0300: I/VIDEO_MUCL VideoDecoderThread stopped
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:045 +0300: I/VIDEO_MUCL VID_Stop: encoder stopped
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:045 +0300: I/VIDEO_MUCL VID_Stop: decoder stopped
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:046 +0300: I/NETWORK_MUCL NET_UpdateShowtimeMediaStatus :0 (old showtime:3)
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:047 +0300: I/SM_MUCL CBCall :  7100
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:047 +0300: CORE:  Call Callback: cmd: 0x7100, callid: 0x0 Call status: 0x7141
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:047 +0300: RTCC: callID:contactId:currentStatus 0:0:0x3.
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:047 +0300: RTCC: call status change
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:047 +0300: RTCC: call status ended
 [;[fg255,0,0;[bg220,220,220;E:  SDK 28/04-12:37:07:047 +0300: AUDIO: -[AudioStream stopAudio] graph status unknown: unknown error
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:047 +0300: VIDEO: (null) Orientation UIDeviceOrientationFaceUp
 [;[fg0,0,255;[bg220,220,220;N:  SDK 28/04-12:37:07:052 +0300: AudioRoute changed: now using (null):Speaker - expecting 2
 [;[fg0,0,255;[bg220,220,220;N:  SDK 28/04-12:37:07:065 +0300: AudioRoute changed: now using (null):Speaker - expecting 2
 [;[fg255,127,0;[bg220,220,220;W:  SDK 28/04-12:37:07:093 +0300: -[VideoOut onVideoStop]
 [;[fg255,127,0;[bg220,220,220;W:  SDK 28/04-12:37:07:093 +0300: -[VideoOut onVideoInterrupted:]
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:093 +0300: Changing the video state from state_active to state_stopped
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:093 +0300: Changing the video state from state_stopped to state_stopped
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:513 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:513 +0300: I/SM_MUCL ProcessMessage 0x101
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:513 +0300: I/SM_MUCL Msg : SMSDK_audstop
 [;[fg0,0,255;I:  SDK 28/04-12:37:07:513 +0300: CORE: AudioCallback: cmd: 0x9104, param: 0
 [;[fg255,0,0;[bg220,220,220;E:  SDK 28/04-12:37:07:513 +0300: AUDIO: -[AudioStream stopAudio] graph status unknown: unknown error
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:513 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:514 +0300: I/NETWORK_MUCL NetworkThread : COMMAND FRAME
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:514 +0300: I/SM_MUCL ProcessMessage 0x111
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:514 +0300: I/SM_MUCL Msg : SMSDK_vidstop : 3
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:514 +0300: I/VIDEO_MUCL VID_Stop: mode : 3 VideoParam.Mode:0
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:514 +0300: I/SM_MUCL ProcessMessage 0x303
 [;[fg0,0,255;I:  UCL 28/04-12:37:07:514 +0300: I/SM_MUCL SMSDK_callstatus status: 0x4
 [;[fg0,0,255;I:  UCL 28/04-12:37:17:515 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:37:17:515 +0300: I/SM_MUCL ProcessMessage 0x3001
 [;[fg0,0,255;I:  UCL 28/04-12:37:17:515 +0300: I/SM_MUCL StateMachine : ProcessMessage_SDK : MUCL_TIMEOUT
 [;[fg0,0,255;I:  UCL 28/04-12:37:17:515 +0300: I/SM_MUCL Msg : MUCL_TIMEOUT
 [;[fg0,0,255;I:  UCL 28/04-12:37:27:517 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:37:27:517 +0300: I/SM_MUCL ProcessMessage 0x3001
 [;[fg0,0,255;I:  UCL 28/04-12:37:27:517 +0300: I/SM_MUCL StateMachine : ProcessMessage_SDK : MUCL_TIMEOUT
 [;[fg0,0,255;I:  UCL 28/04-12:37:27:517 +0300: I/SM_MUCL Msg : MUCL_TIMEOUT
 [;[fg0,0,255;I:  UCL 28/04-12:37:37:519 +0300: I/NETWORK_MUCL NetworkThread : Connected Timeout
 [;[fg0,0,255;I:  UCL 28/04-12:37:37:519 +0300: I/SM_MUCL ProcessMessage 0x3001
 [;[fg0,0,255;I:  UCL 28/04-12:37:37:519 +0300: I/SM_MUCL StateMachine : ProcessMessage_SDK : MUCL_TIMEOUT
 [;[fg0,0,255;I:  UCL 28/04-12:37:37:519 +0300: I/SM_MUCL Msg : MUCL_TIMEOUT
 
 */


@implementation CallReceiver4

+(NSString*)infoMessage{
	return @"onWillStart: reset. onStart: start round. onRinging: pickup. onCallFinished: end round. onStopped: reset. onCallProceeding: resumeCall. ";
}

-(void)onWillStart{
	[super reset];
	[super onWillStart];
}

- (void)onStarted{
	[super onStarted];
	
}

- (void)onStopped{
	[super onStopped];
	[super reset];
	
	//restart receiver
	[super start];
}

- (void)onConnectionLost{
	[super onConnectionLost];
	[self hangupCall];
//	[self reset];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self reset];
		[self performSelector:@selector(start) withObject:nil afterDelay:4];
	});
}

- (void)onConnectionRepaired{
	[super onConnectionRepaired];
}

- (void)onRinging:(id<CMCall>)call{
	[super onRinging:call];
	[self.tester onRoundStarted];
	[self resumeCall];
}

- (void)onCallCreated:(id<CMCall>)call{
	[super onCallCreated:call];
}

- (void)onCallStarted:(id<CMCall>)call{
	[super onCallStarted:call];
}

- (void)onCallProceeding:(id<CMCall>)call{
	[super onCallProceeding:call];
	//	[super resumeCall];
}

- (void)onCallFinished:(id<CMCall>)call{
	[super onCallFinished:call];
	[self.tester onRoundEnded];
}

- (void)onHangupCall:(id<CMCall>)call{
	[super onHangupCall:call];
}

- (void)onError:(NSError*)error
		 reason:(CMFailureReason)reason{
	[super onError:error reason:reason];
}

- (void)onStatusChanged:(sdkStatus_t)status{
	[super onStatusChanged:status];
}

#pragma mark Used by Calls Tester, not by RTCC

- (void)stopCurrentRound:(CallsTester*)tester{
}

- (void)startNextRound:(CallsTester*)tester{
	
}
@end
