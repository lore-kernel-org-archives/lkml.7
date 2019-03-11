Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0214C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B7B204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfCKNY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:28 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42269 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfCKNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MIMXC-1hFQBe0sgm-00EJHb for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 050/114] net: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:02 +0100
Message-Id: <1552310346-7629-51-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:TjX9xXIuPfHeCf9RLMyICOta9Fe1MZ1ziYbcDDWvzztyxCnbO9H
 Mt2olzeW3ByHss++QvaJmSwmQQTh6O8fnALVcz50p5iy1GB+KAJsKjUBNxkFed8ePU6vF3f
 Px8bWlsPRMOpWmW6ch9siwUivWZkPWBI43AIBE6w2+mDncFtmnoF/X+SQoqQc8Y/xOf6UGS
 Tr36nmAR8DululGlf/1Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ygFzQrr/aT4=:qS5afT6N9spMr/cTcYM9zF
 6CuWFQXUzs1ChMFFesK+Wcmt4KJi0J0z5HyyX8IHgdpfRkVAycnQqiZfgGJqLz9Cp1YXD82hK
 x1xBrZ+gPNK2Gh0BlnVW9R3ahdMBBeAEvkH9EwphhL51Txm4C2kFhIAul219Cw3fD4O+6Epbj
 ql/3NDyFdI7e4Vsat9/DXUJjWiARKlf8w3H6UFPH6eF+sB85mo0vrEATe4Rzwy+FNaAKeq1lj
 a7MHwBbcRUO7UzDmL0JX0PjVCpbqYc7wnF4LZ4PCVvgb1JZkX5Iz2UwJfOFgjzbJzmRAkD6KC
 4cTa+7uHh+ywtjhdMnMfaNY9ijXHMG/uNo7tesqfnyD7xWjBDQBOxiWXxdZiHfZN5GCyWHBez
 tW+WcodniAuwqGcDkLxfJIndyE1rnCz/O3gnWoAeiCB7e80uPFHw9Xc0yDchdSCpTKKi2qzbY
 0yIjURyNXXnprGl4G0ihOlCVOQdxRlrIKZ0R5diIrFkqhF0tHZtUHkryz7ZSKwxmEkeudt3Qw
 jQwoCAeJv0RvIr//rHUhRm3vPWkft9XbLXhzsp8NoPKL8MobBPQdyvorAKF0qxkBYMsC75SIU
 hk8zrVvC720q1uxjP3Cn7jAuwLfLNi5ogxEYsTIel1MENud7kMrRJiM8eOKUbpHovahMRVf7Y
 HlEYpy1W4E+RneHfM+Tdl2wNQUaxTAk+7Ib2MzeRTwxb5OtXOfbQOwyb4k0uzEZ5dRgT2uLox
 GTKfUQVwkt4IuyDbDatHoqWx4f6TJ7wk5jC86BYHMpo0nHIzUwF+w646hAa8+4OWKa+IrWUP/
 HYkl/H/3HfRA7tNuVRZwX2uUGSVbkoqMtCf/eZYEIh1bLiCYw0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 net/Kconfig                 |  14 +--
 net/batman-adv/Kconfig      |  10 +-
 net/bluetooth/Kconfig       |   2 +-
 net/ife/Kconfig             |   2 +-
 net/ipv4/Kconfig            | 231 ++++++++++++++++++++++----------------------
 net/ipv4/netfilter/Kconfig  |   4 +-
 net/ipv6/netfilter/Kconfig  |  26 ++---
 net/mpls/Kconfig            |  10 +-
 net/netfilter/Kconfig       |  10 +-
 net/netfilter/ipset/Kconfig |   2 +-
 net/netfilter/ipvs/Kconfig  |  68 ++++++-------
 net/nfc/hci/Kconfig         |  14 +--
 net/rds/Kconfig             |   4 +-
 net/sched/Kconfig           | 130 ++++++++++++-------------
 net/wireless/Kconfig        |  38 ++++----
 net/xfrm/Kconfig            |  10 +-
 16 files changed, 287 insertions(+), 288 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 1efe1f9..617892c 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -259,7 +259,7 @@ config XPS
 	default y
 
 config HWBM
-       bool
+	bool
 
 config CGROUP_NET_PRIO
 	bool "Network priority cgroup"
@@ -310,12 +310,12 @@ config BPF_STREAM_PARSER
 	select STREAM_PARSER
 	select NET_SOCK_MSG
 	---help---
-	 Enabling this allows a stream parser to be used with
-	 BPF_MAP_TYPE_SOCKMAP.
+	  Enabling this allows a stream parser to be used with
+	  BPF_MAP_TYPE_SOCKMAP.
 
-	 BPF_MAP_TYPE_SOCKMAP provides a map type to use with network sockets.
-	 It can be used to enforce socket policy, implement socket redirects,
-	 etc.
+	  BPF_MAP_TYPE_SOCKMAP provides a map type to use with network sockets.
+	  It can be used to enforce socket policy, implement socket redirects,
+	  etc.
 
 config NET_FLOW_LIMIT
 	bool
@@ -436,7 +436,7 @@ config NET_DEVLINK
 	  monitoring.
 
 config PAGE_POOL
-       bool
+	bool
 
 config FAILOVER
 	tristate "Generic failover module"
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index a31db5e..377d400 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -24,11 +24,11 @@ config BATMAN_ADV
 	depends on NET
 	select LIBCRC32C
 	help
-          B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
-          a routing protocol for multi-hop ad-hoc mesh networks. The
-          networks may be wired or wireless. See
-          https://www.open-mesh.org/ for more information and user space
-          tools.
+	  B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
+	  a routing protocol for multi-hop ad-hoc mesh networks. The
+	  networks may be wired or wireless. See
+	  https://www.open-mesh.org/ for more information and user space
+	  tools.
 
 config BATMAN_ADV_BATMAN_V
 	bool "B.A.T.M.A.N. V protocol"
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index db82a40..855a9c7 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -28,7 +28,7 @@ menuconfig BT
 		L2CAP (Logical Link Control and Adaptation Protocol)
 		SMP (Security Manager Protocol) on LE (Low Energy) links
 	     HCI Device drivers (Interface to the hardware)
-	     RFCOMM Module (RFCOMM Protocol)  
+	     RFCOMM Module (RFCOMM Protocol)
 	     BNEP Module (Bluetooth Network Encapsulation Protocol)
 	     CMTP Module (CAPI Message Transport Protocol)
 	     HIDP Module (Human Interface Device Protocol)
diff --git a/net/ife/Kconfig b/net/ife/Kconfig
index 31e48b6..a0eb392 100644
--- a/net/ife/Kconfig
+++ b/net/ife/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig NET_IFE
 	depends on NET
-        tristate "Inter-FE based on IETF ForCES InterFE LFB"
+	tristate "Inter-FE based on IETF ForCES InterFE LFB"
 	default n
 	help
 	  Say Y here to add support of IFE encapsulation protocol
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 32cae39..eafedbe 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -179,8 +179,8 @@ config NET_IPIP
 config NET_IPGRE_DEMUX
 	tristate "IP: GRE demultiplexer"
 	help
-	 This is helper module to demultiplex GRE packets on GRE version field criteria.
-	 Required by ip_gre and pptp modules.
+	  This is helper module to demultiplex GRE packets on GRE version field criteria.
+	  Required by ip_gre and pptp modules.
 
 config NET_IP_TUNNEL
 	tristate
@@ -485,200 +485,199 @@ config TCP_CONG_BIC
 	tristate "Binary Increase Congestion (BIC) control"
 	default m
 	---help---
-	BIC-TCP is a sender-side only change that ensures a linear RTT
-	fairness under large windows while offering both scalability and
-	bounded TCP-friendliness. The protocol combines two schemes
-	called additive increase and binary search increase. When the
-	congestion window is large, additive increase with a large
-	increment ensures linear RTT fairness as well as good
-	scalability. Under small congestion windows, binary search
-	increase provides TCP friendliness.
-	See http://www.csc.ncsu.edu/faculty/rhee/export/bitcp/
+	  BIC-TCP is a sender-side only change that ensures a linear RTT
+	  fairness under large windows while offering both scalability and
+	  bounded TCP-friendliness. The protocol combines two schemes
+	  called additive increase and binary search increase. When the
+	  congestion window is large, additive increase with a large
+	  increment ensures linear RTT fairness as well as good
+	  scalability. Under small congestion windows, binary search
+	  increase provides TCP friendliness.
+	  See http://www.csc.ncsu.edu/faculty/rhee/export/bitcp/
 
 config TCP_CONG_CUBIC
 	tristate "CUBIC TCP"
 	default y
 	---help---
-	This is version 2.0 of BIC-TCP which uses a cubic growth function
-	among other techniques.
-	See http://www.csc.ncsu.edu/faculty/rhee/export/bitcp/cubic-paper.pdf
+	  This is version 2.0 of BIC-TCP which uses a cubic growth function
+	  among other techniques.
+	  See http://www.csc.ncsu.edu/faculty/rhee/export/bitcp/cubic-paper.pdf
 
 config TCP_CONG_WESTWOOD
 	tristate "TCP Westwood+"
 	default m
 	---help---
-	TCP Westwood+ is a sender-side only modification of the TCP Reno
-	protocol stack that optimizes the performance of TCP congestion
-	control. It is based on end-to-end bandwidth estimation to set
-	congestion window and slow start threshold after a congestion
-	episode. Using this estimation, TCP Westwood+ adaptively sets a
-	slow start threshold and a congestion window which takes into
-	account the bandwidth used  at the time congestion is experienced.
-	TCP Westwood+ significantly increases fairness wrt TCP Reno in
-	wired networks and throughput over wireless links.
+	  TCP Westwood+ is a sender-side only modification of the TCP Reno
+	  protocol stack that optimizes the performance of TCP congestion
+	  control. It is based on end-to-end bandwidth estimation to set
+	  congestion window and slow start threshold after a congestion
+	  episode. Using this estimation, TCP Westwood+ adaptively sets a
+	  slow start threshold and a congestion window which takes into
+	  account the bandwidth used  at the time congestion is experienced.
+	  TCP Westwood+ significantly increases fairness wrt TCP Reno in
+	  wired networks and throughput over wireless links.
 
 config TCP_CONG_HTCP
-        tristate "H-TCP"
-        default m
+	tristate "H-TCP"
+	default m
 	---help---
-	H-TCP is a send-side only modifications of the TCP Reno
-	protocol stack that optimizes the performance of TCP
-	congestion control for high speed network links. It uses a
-	modeswitch to change the alpha and beta parameters of TCP Reno
-	based on network conditions and in a way so as to be fair with
-	other Reno and H-TCP flows.
+	  H-TCP is a send-side only modifications of the TCP Reno
+	  protocol stack that optimizes the performance of TCP
+	  congestion control for high speed network links. It uses a
+	  modeswitch to change the alpha and beta parameters of TCP Reno
+	  based on network conditions and in a way so as to be fair with
+	  other Reno and H-TCP flows.
 
 config TCP_CONG_HSTCP
 	tristate "High Speed TCP"
 	default n
 	---help---
-	Sally Floyd's High Speed TCP (RFC 3649) congestion control.
-	A modification to TCP's congestion control mechanism for use
-	with large congestion windows. A table indicates how much to
-	increase the congestion window by when an ACK is received.
- 	For more detail	see http://www.icir.org/floyd/hstcp.html
+	  Sally Floyd's High Speed TCP (RFC 3649) congestion control.
+	  A modification to TCP's congestion control mechanism for use
+	  with large congestion windows. A table indicates how much to
+	  increase the congestion window by when an ACK is received.
+	  For more detail see http://www.icir.org/floyd/hstcp.html
 
 config TCP_CONG_HYBLA
 	tristate "TCP-Hybla congestion control algorithm"
 	default n
 	---help---
-	TCP-Hybla is a sender-side only change that eliminates penalization of
-	long-RTT, large-bandwidth connections, like when satellite legs are
-	involved, especially when sharing a common bottleneck with normal
-	terrestrial connections.
+	  TCP-Hybla is a sender-side only change that eliminates penalization of
+	  long-RTT, large-bandwidth connections, like when satellite legs are
+	  involved, especially when sharing a common bottleneck with normal
+	  terrestrial connections.
 
 config TCP_CONG_VEGAS
 	tristate "TCP Vegas"
 	default n
 	---help---
-	TCP Vegas is a sender-side only change to TCP that anticipates
-	the onset of congestion by estimating the bandwidth. TCP Vegas
-	adjusts the sending rate by modifying the congestion
-	window. TCP Vegas should provide less packet loss, but it is
-	not as aggressive as TCP Reno.
+	  TCP Vegas is a sender-side only change to TCP that anticipates
+	  the onset of congestion by estimating the bandwidth. TCP Vegas
+	  adjusts the sending rate by modifying the congestion
+	  window. TCP Vegas should provide less packet loss, but it is
+	  not as aggressive as TCP Reno.
 
 config TCP_CONG_NV
-       tristate "TCP NV"
-       default n
-       ---help---
-       TCP NV is a follow up to TCP Vegas. It has been modified to deal with
-       10G networks, measurement noise introduced by LRO, GRO and interrupt
-       coalescence. In addition, it will decrease its cwnd multiplicatively
-       instead of linearly.
+	tristate "TCP NV"
+	default n
+	---help---
+	  TCP NV is a follow up to TCP Vegas. It has been modified to deal with
+	  10G networks, measurement noise introduced by LRO, GRO and interrupt
+	  coalescence. In addition, it will decrease its cwnd multiplicatively
+	  instead of linearly.
 
-       Note that in general congestion avoidance (cwnd decreased when # packets
-       queued grows) cannot coexist with congestion control (cwnd decreased only
-       when there is packet loss) due to fairness issues. One scenario when they
-       can coexist safely is when the CA flows have RTTs << CC flows RTTs.
+	  Note that in general congestion avoidance (cwnd decreased when # packets
+	  queued grows) cannot coexist with congestion control (cwnd decreased only
+	  when there is packet loss) due to fairness issues. One scenario when they
+	  can coexist safely is when the CA flows have RTTs << CC flows RTTs.
 
-       For further details see http://www.brakmo.org/networking/tcp-nv/
+	  For further details see http://www.brakmo.org/networking/tcp-nv/
 
 config TCP_CONG_SCALABLE
 	tristate "Scalable TCP"
 	default n
 	---help---
-	Scalable TCP is a sender-side only change to TCP which uses a
-	MIMD congestion control algorithm which has some nice scaling
-	properties, though is known to have fairness issues.
-	See http://www.deneholme.net/tom/scalable/
+	  Scalable TCP is a sender-side only change to TCP which uses a
+	  MIMD congestion control algorithm which has some nice scaling
+	  properties, though is known to have fairness issues.
+	  See http://www.deneholme.net/tom/scalable/
 
 config TCP_CONG_LP
 	tristate "TCP Low Priority"
 	default n
 	---help---
-	TCP Low Priority (TCP-LP), a distributed algorithm whose goal is
-	to utilize only the excess network bandwidth as compared to the
-	``fair share`` of bandwidth as targeted by TCP.
-	See http://www-ece.rice.edu/networks/TCP-LP/
+	  TCP Low Priority (TCP-LP), a distributed algorithm whose goal is
+	  to utilize only the excess network bandwidth as compared to the
+	  ``fair share`` of bandwidth as targeted by TCP.
+	  See http://www-ece.rice.edu/networks/TCP-LP/
 
 config TCP_CONG_VENO
 	tristate "TCP Veno"
 	default n
 	---help---
-	TCP Veno is a sender-side only enhancement of TCP to obtain better
-	throughput over wireless networks. TCP Veno makes use of state
-	distinguishing to circumvent the difficult judgment of the packet loss
-	type. TCP Veno cuts down less congestion window in response to random
-	loss packets.
-	See <http://ieeexplore.ieee.org/xpl/freeabs_all.jsp?arnumber=1177186>
+	  TCP Veno is a sender-side only enhancement of TCP to obtain better
+	  throughput over wireless networks. TCP Veno makes use of state
+	  distinguishing to circumvent the difficult judgment of the packet loss
+	  type. TCP Veno cuts down less congestion window in response to random
+	  loss packets.
+	  See <http://ieeexplore.ieee.org/xpl/freeabs_all.jsp?arnumber=1177186>
 
 config TCP_CONG_YEAH
 	tristate "YeAH TCP"
 	select TCP_CONG_VEGAS
 	default n
 	---help---
-	YeAH-TCP is a sender-side high-speed enabled TCP congestion control
-	algorithm, which uses a mixed loss/delay approach to compute the
-	congestion window. It's design goals target high efficiency,
-	internal, RTT and Reno fairness, resilience to link loss while
-	keeping network elements load as low as possible.
+	  YeAH-TCP is a sender-side high-speed enabled TCP congestion control
+	  algorithm, which uses a mixed loss/delay approach to compute the
+	  congestion window. It's design goals target high efficiency,
+	  internal, RTT and Reno fairness, resilience to link loss while
+	  keeping network elements load as low as possible.
 
-	For further details look here:
-	  http://wil.cs.caltech.edu/pfldnet2007/paper/YeAH_TCP.pdf
+	  For further details look here:
+	    http://wil.cs.caltech.edu/pfldnet2007/paper/YeAH_TCP.pdf
 
 config TCP_CONG_ILLINOIS
 	tristate "TCP Illinois"
 	default n
 	---help---
-	TCP-Illinois is a sender-side modification of TCP Reno for
-	high speed long delay links. It uses round-trip-time to
-	adjust the alpha and beta parameters to achieve a higher average
-	throughput and maintain fairness.
+	  TCP-Illinois is a sender-side modification of TCP Reno for
+	  high speed long delay links. It uses round-trip-time to
+	  adjust the alpha and beta parameters to achieve a higher average
+	  throughput and maintain fairness.
 
-	For further details see:
-	  http://www.ews.uiuc.edu/~shaoliu/tcpillinois/index.html
+	  For further details see:
+	    http://www.ews.uiuc.edu/~shaoliu/tcpillinois/index.html
 
 config TCP_CONG_DCTCP
 	tristate "DataCenter TCP (DCTCP)"
 	default n
 	---help---
-	DCTCP leverages Explicit Congestion Notification (ECN) in the network to
-	provide multi-bit feedback to the end hosts. It is designed to provide:
+	  DCTCP leverages Explicit Congestion Notification (ECN) in the network to
+	  provide multi-bit feedback to the end hosts. It is designed to provide:
 
-	- High burst tolerance (incast due to partition/aggregate),
-	- Low latency (short flows, queries),
-	- High throughput (continuous data updates, large file transfers) with
-	  commodity, shallow-buffered switches.
+	  - High burst tolerance (incast due to partition/aggregate),
+	  - Low latency (short flows, queries),
+	  - High throughput (continuous data updates, large file transfers) with
+	    commodity, shallow-buffered switches.
 
-	All switches in the data center network running DCTCP must support
-	ECN marking and be configured for marking when reaching defined switch
-	buffer thresholds. The default ECN marking threshold heuristic for
-	DCTCP on switches is 20 packets (30KB) at 1Gbps, and 65 packets
-	(~100KB) at 10Gbps, but might need further careful tweaking.
+	  All switches in the data center network running DCTCP must support
+	  ECN marking and be configured for marking when reaching defined switch
+	  buffer thresholds. The default ECN marking threshold heuristic for
+	  DCTCP on switches is 20 packets (30KB) at 1Gbps, and 65 packets
+	  (~100KB) at 10Gbps, but might need further careful tweaking.
 
-	For further details see:
-	  http://simula.stanford.edu/~alizade/Site/DCTCP_files/dctcp-final.pdf
+	  For further details see:
+	    http://simula.stanford.edu/~alizade/Site/DCTCP_files/dctcp-final.pdf
 
 config TCP_CONG_CDG
 	tristate "CAIA Delay-Gradient (CDG)"
 	default n
 	---help---
-	CAIA Delay-Gradient (CDG) is a TCP congestion control that modifies
-	the TCP sender in order to:
+	  CAIA Delay-Gradient (CDG) is a TCP congestion control that modifies
+	  the TCP sender in order to:
 
-	  o Use the delay gradient as a congestion signal.
-	  o Back off with an average probability that is independent of the RTT.
-	  o Coexist with flows that use loss-based congestion control.
-	  o Tolerate packet loss unrelated to congestion.
+	    o Use the delay gradient as a congestion signal.
+	    o Back off with an average probability that is independent of the RTT.
+	    o Coexist with flows that use loss-based congestion control.
+	    o Tolerate packet loss unrelated to congestion.
 
-	For further details see:
-	  D.A. Hayes and G. Armitage. "Revisiting TCP congestion control using
-	  delay gradients." In Networking 2011. Preprint: http://goo.gl/No3vdg
+	  For further details see:
+	    D.A. Hayes and G. Armitage. "Revisiting TCP congestion control using
+	    delay gradients." In Networking 2011. Preprint: http://goo.gl/No3vdg
 
 config TCP_CONG_BBR
 	tristate "BBR TCP"
 	default n
 	---help---
-
-	BBR (Bottleneck Bandwidth and RTT) TCP congestion control aims to
-	maximize network utilization and minimize queues. It builds an explicit
-	model of the the bottleneck delivery rate and path round-trip
-	propagation delay. It tolerates packet loss and delay unrelated to
-	congestion. It can operate over LAN, WAN, cellular, wifi, or cable
-	modem links. It can coexist with flows that use loss-based congestion
-	control, and can operate with shallow buffers, deep buffers,
-	bufferbloat, policers, or AQM schemes that do not provide a delay
-	signal. It requires the fq ("Fair Queue") pacing packet scheduler.
+	  BBR (Bottleneck Bandwidth and RTT) TCP congestion control aims to
+	  maximize network utilization and minimize queues. It builds an explicit
+	  model of the the bottleneck delivery rate and path round-trip
+	  propagation delay. It tolerates packet loss and delay unrelated to
+	  congestion. It can operate over LAN, WAN, cellular, wifi, or cable
+	  modem links. It can coexist with flows that use loss-based congestion
+	  control, and can operate with shallow buffers, deep buffers,
+	  bufferbloat, policers, or AQM schemes that do not provide a delay
+	  signal. It requires the fq ("Fair Queue") pacing packet scheduler.
 
 choice
 	prompt "Default TCP congestion control"
diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index c98391d..8d0fdfa 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -294,7 +294,7 @@ config IP_NF_TARGET_ECN
 	depends on NETFILTER_ADVANCED
 	---help---
 	  This option adds a `ECN' target, which can be used in the iptables mangle
-	  table.  
+	  table.
 
 	  You can use this target to remove the ECN bits from the IPv4 header of
 	  an IP packet.  This is particularly useful, if you need to work around
@@ -331,7 +331,7 @@ config IP_NF_SECURITY
 	help
 	  This option adds a `security' table to iptables, for use
 	  with Mandatory Access Control (MAC) policy.
-	 
+
 	  If unsure, say N.
 
 endif # IP_NF_IPTABLES
diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index ddc99a1..fea22c2 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -177,13 +177,13 @@ config IP6_NF_MATCH_RT
 	  To compile it as a module, choose M here.  If unsure, say N.
 
 config IP6_NF_MATCH_SRH
-        tristate '"srh" Segment Routing header match support'
-        depends on NETFILTER_ADVANCED
-        help
-          srh matching allows you to match packets based on the segment
+	tristate '"srh" Segment Routing header match support'
+	depends on NETFILTER_ADVANCED
+	help
+	  srh matching allows you to match packets based on the segment
 	  routing header of the packet.
 
-          To compile it as a module, choose M here.  If unsure, say N.
+	  To compile it as a module, choose M here.  If unsure, say N.
 
 # The targets
 config IP6_NF_TARGET_HL
@@ -252,14 +252,14 @@ config IP6_NF_RAW
 
 # security table for MAC policy
 config IP6_NF_SECURITY
-       tristate "Security table"
-       depends on SECURITY
-       depends on NETFILTER_ADVANCED
-       help
-         This option adds a `security' table to iptables, for use
-         with Mandatory Access Control (MAC) policy.
-
-         If unsure, say N.
+	tristate "Security table"
+	depends on SECURITY
+	depends on NETFILTER_ADVANCED
+	help
+	  This option adds a `security' table to iptables, for use
+	  with Mandatory Access Control (MAC) policy.
+
+	  If unsure, say N.
 
 config IP6_NF_NAT
 	tristate "ip6tables NAT support"
diff --git a/net/mpls/Kconfig b/net/mpls/Kconfig
index 801ea90..683d838 100644
--- a/net/mpls/Kconfig
+++ b/net/mpls/Kconfig
@@ -18,20 +18,20 @@ if MPLS
 config NET_MPLS_GSO
 	tristate "MPLS: GSO support"
 	help
-	 This is helper module to allow segmentation of non-MPLS GSO packets
-	 that have had MPLS stack entries pushed onto them and thus
-	 become MPLS GSO packets.
+	  This is helper module to allow segmentation of non-MPLS GSO packets
+	  that have had MPLS stack entries pushed onto them and thus
+	  become MPLS GSO packets.
 
 config MPLS_ROUTING
 	tristate "MPLS: routing support"
 	depends on NET_IP_TUNNEL || NET_IP_TUNNEL=n
 	---help---
-	 Add support for forwarding of mpls packets.
+	  Add support for forwarding of mpls packets.
 
 config MPLS_IPTUNNEL
 	tristate "MPLS: IP over MPLS tunnel support"
 	depends on LWTUNNEL && MPLS_ROUTING
 	---help---
-	 mpls ip tunnel support.
+	  mpls ip tunnel support.
 
 endif # MPLS
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index d43ffb0..1be1ebd 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -33,7 +33,7 @@ config NETFILTER_NETLINK_QUEUE
 	help
 	  If this option is enabled, the kernel will include support
 	  for queueing packets via NFNETLINK.
-	  
+
 config NETFILTER_NETLINK_LOG
 	tristate "Netfilter LOG over NFNETLINK interface"
 	default m if NETFILTER_ADVANCED=n
@@ -692,7 +692,7 @@ config NF_FLOW_TABLE_INET
 	tristate "Netfilter flow table mixed IPv4/IPv6 module"
 	depends on NF_FLOW_TABLE
 	help
-          This option adds the flow table mixed IPv4/IPv6 support.
+	  This option adds the flow table mixed IPv4/IPv6 support.
 
 	  To compile it as a module, choose M here.
 
@@ -793,7 +793,7 @@ config NETFILTER_XT_TARGET_CLASSIFY
 	  the priority of a packet. Some qdiscs can use this value for
 	  classification, among these are:
 
-  	  atm, cbq, dsmark, pfifo_fast, htb, prio
+	  atm, cbq, dsmark, pfifo_fast, htb, prio
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
@@ -1482,7 +1482,7 @@ config NETFILTER_XT_MATCH_REALM
 	  This option adds a `realm' match, which allows you to use the realm
 	  key from the routing subsystem inside iptables.
 
-	  This match pretty much resembles the CONFIG_NET_CLS_ROUTE4 option 
+	  This match pretty much resembles the CONFIG_NET_CLS_ROUTE4 option
 	  in tc world.
 
 	  If you want to compile it as a module, say M here and read
@@ -1503,7 +1503,7 @@ config NETFILTER_XT_MATCH_SCTP
 	depends on NETFILTER_ADVANCED
 	default IP_SCTP
 	help
-	  With this option enabled, you will be able to use the 
+	  With this option enabled, you will be able to use the
 	  `sctp' match in order to match on SCTP source/destination ports
 	  and SCTP chunk types.
 
diff --git a/net/netfilter/ipset/Kconfig b/net/netfilter/ipset/Kconfig
index 4083a80..08b0e73 100644
--- a/net/netfilter/ipset/Kconfig
+++ b/net/netfilter/ipset/Kconfig
@@ -18,7 +18,7 @@ config IP_SET_MAX
 	range 2 65534
 	depends on IP_SET
 	help
-	  You can define here default value of the maximum number 
+	  You can define here default value of the maximum number
 	  of IP sets for the kernel.
 
 	  The value can be overridden by the 'max_sets' module
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 8401cef..f9edaf3 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -25,7 +25,7 @@ menuconfig IP_VS
 
 if IP_VS
 
-config	IP_VS_IPV6
+config IP_VS_IPV6
 	bool "IPv6 support for IPVS"
 	depends on IPV6 = y || IP_VS = IPV6
 	select IP6_NF_IPTABLES
@@ -35,14 +35,14 @@ config	IP_VS_IPV6
 
 	  Say Y if unsure.
 
-config	IP_VS_DEBUG
+config IP_VS_DEBUG
 	bool "IP virtual server debugging"
 	---help---
 	  Say Y here if you want to get additional messages useful in
 	  debugging the IP virtual server code. You can change the debug
 	  level in /proc/sys/net/ipv4/vs/debug_level
 
-config	IP_VS_TAB_BITS
+config IP_VS_TAB_BITS
 	int "IPVS connection table size (the Nth power of 2)"
 	range 8 20
 	default 12
@@ -75,34 +75,34 @@ config	IP_VS_TAB_BITS
 
 comment "IPVS transport protocol load balancing support"
 
-config	IP_VS_PROTO_TCP
+config IP_VS_PROTO_TCP
 	bool "TCP load balancing support"
 	---help---
 	  This option enables support for load balancing TCP transport
 	  protocol. Say Y if unsure.
 
-config	IP_VS_PROTO_UDP
+config IP_VS_PROTO_UDP
 	bool "UDP load balancing support"
 	---help---
 	  This option enables support for load balancing UDP transport
 	  protocol. Say Y if unsure.
 
-config	IP_VS_PROTO_AH_ESP
+config IP_VS_PROTO_AH_ESP
 	def_bool IP_VS_PROTO_ESP || IP_VS_PROTO_AH
 
-config	IP_VS_PROTO_ESP
+config IP_VS_PROTO_ESP
 	bool "ESP load balancing support"
 	---help---
 	  This option enables support for load balancing ESP (Encapsulation
 	  Security Payload) transport protocol. Say Y if unsure.
 
-config	IP_VS_PROTO_AH
+config IP_VS_PROTO_AH
 	bool "AH load balancing support"
 	---help---
 	  This option enables support for load balancing AH (Authentication
 	  Header) transport protocol. Say Y if unsure.
 
-config  IP_VS_PROTO_SCTP
+config IP_VS_PROTO_SCTP
 	bool "SCTP load balancing support"
 	select LIBCRC32C
 	---help---
@@ -111,7 +111,7 @@ config  IP_VS_PROTO_SCTP
 
 comment "IPVS scheduler"
 
-config	IP_VS_RR
+config IP_VS_RR
 	tristate "round-robin scheduling"
 	---help---
 	  The robin-robin scheduling algorithm simply directs network
@@ -119,8 +119,8 @@ config	IP_VS_RR
 
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
- 
-config	IP_VS_WRR
+
+config IP_VS_WRR
 	tristate "weighted round-robin scheduling"
 	---help---
 	  The weighted robin-robin scheduling algorithm directs network
@@ -133,18 +133,18 @@ config	IP_VS_WRR
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_LC
-        tristate "least-connection scheduling"
+config IP_VS_LC
+	tristate "least-connection scheduling"
 	---help---
 	  The least-connection scheduling algorithm directs network
-	  connections to the server with the least number of active 
+	  connections to the server with the least number of active
 	  connections.
 
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_WLC
-        tristate "weighted least-connection scheduling"
+config IP_VS_WLC
+	tristate "weighted least-connection scheduling"
 	---help---
 	  The weighted least-connection scheduling algorithm directs network
 	  connections to the server with the least active connections
@@ -153,7 +153,7 @@ config	IP_VS_WLC
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config  IP_VS_FO
+config IP_VS_FO
 		tristate "weighted failover scheduling"
 	---help---
 	  The weighted failover scheduling algorithm directs network
@@ -163,7 +163,7 @@ config  IP_VS_FO
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config  IP_VS_OVF
+config IP_VS_OVF
 	tristate "weighted overflow scheduling"
 	---help---
 	  The weighted overflow scheduling algorithm directs network
@@ -174,7 +174,7 @@ config  IP_VS_OVF
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_LBLC
+config IP_VS_LBLC
 	tristate "locality-based least-connection scheduling"
 	---help---
 	  The locality-based least-connection scheduling algorithm is for
@@ -188,11 +188,11 @@ config	IP_VS_LBLC
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config  IP_VS_LBLCR
+config IP_VS_LBLCR
 	tristate "locality-based least-connection with replication scheduling"
 	---help---
 	  The locality-based least-connection with replication scheduling
-	  algorithm is also for destination IP load balancing. It is 
+	  algorithm is also for destination IP load balancing. It is
 	  usually used in cache cluster. It differs from the LBLC scheduling
 	  as follows: the load balancer maintains mappings from a target
 	  to a set of server nodes that can serve the target. Requests for
@@ -206,7 +206,7 @@ config  IP_VS_LBLCR
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_DH
+config IP_VS_DH
 	tristate "destination hashing scheduling"
 	---help---
 	  The destination hashing scheduling algorithm assigns network
@@ -216,7 +216,7 @@ config	IP_VS_DH
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_SH
+config IP_VS_SH
 	tristate "source hashing scheduling"
 	---help---
 	  The source hashing scheduling algorithm assigns network
@@ -226,7 +226,7 @@ config	IP_VS_SH
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_MH
+config IP_VS_MH
 	tristate "maglev hashing scheduling"
 	---help---
 	  The maglev consistent hashing scheduling algorithm provides the
@@ -245,12 +245,12 @@ config	IP_VS_MH
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_SED
+config IP_VS_SED
 	tristate "shortest expected delay scheduling"
 	---help---
 	  The shortest expected delay scheduling algorithm assigns network
-	  connections to the server with the shortest expected delay. The 
-	  expected delay that the job will experience is (Ci + 1) / Ui if 
+	  connections to the server with the shortest expected delay. The
+	  expected delay that the job will experience is (Ci + 1) / Ui if
 	  sent to the ith server, in which Ci is the number of connections
 	  on the ith server and Ui is the fixed service rate (weight)
 	  of the ith server.
@@ -258,7 +258,7 @@ config	IP_VS_SED
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_NQ
+config IP_VS_NQ
 	tristate "never queue scheduling"
 	---help---
 	  The never queue scheduling algorithm adopts a two-speed model.
@@ -306,8 +306,8 @@ config IP_VS_MH_TAB_INDEX
 
 comment 'IPVS application helper'
 
-config	IP_VS_FTP
-  	tristate "FTP protocol helper"
+config IP_VS_FTP
+	tristate "FTP protocol helper"
 	depends on IP_VS_PROTO_TCP && NF_CONNTRACK && NF_NAT && \
 		NF_CONNTRACK_FTP
 	select IP_VS_NFCT
@@ -322,7 +322,7 @@ config	IP_VS_FTP
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_NFCT
+config IP_VS_NFCT
 	bool "Netfilter connection tracking"
 	depends on NF_CONNTRACK
 	---help---
@@ -330,9 +330,9 @@ config	IP_VS_NFCT
 	  connection state to be exported to the Netfilter framework
 	  for filtering purposes.
 
-config	IP_VS_PE_SIP
+config IP_VS_PE_SIP
 	tristate "SIP persistence engine"
-        depends on IP_VS_PROTO_UDP
+	depends on IP_VS_PROTO_UDP
 	depends on NF_CONNTRACK_SIP
 	---help---
 	  Allow persistence based on the SIP Call-ID
diff --git a/net/nfc/hci/Kconfig b/net/nfc/hci/Kconfig
index fd67f51..5b059fc 100644
--- a/net/nfc/hci/Kconfig
+++ b/net/nfc/hci/Kconfig
@@ -1,11 +1,11 @@
 config NFC_HCI
-       depends on NFC
-       tristate "NFC HCI implementation"
-       default n
-       help
-	 Say Y here if you want to build support for a kernel NFC HCI
-	 implementation. This is mostly needed for devices that only process
-	 HCI frames, like for example the NXP pn544.
+	depends on NFC
+	tristate "NFC HCI implementation"
+	default n
+	help
+	  Say Y here if you want to build support for a kernel NFC HCI
+	  implementation. This is mostly needed for devices that only process
+	  HCI frames, like for example the NXP pn544.
 
 config NFC_SHDLC
 	depends on NFC_HCI
diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index b909211..d493822 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -22,6 +22,6 @@ config RDS_TCP
 	  This transport does not support RDMA operations.
 
 config RDS_DEBUG
-        bool "RDS debugging messages"
+	bool "RDS debugging messages"
 	depends on RDS
-        default n
+	default n
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 1b9afde..12da119 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -730,8 +730,8 @@ config NET_CLS_ACT
 
 config NET_ACT_POLICE
 	tristate "Traffic Policing"
-        depends on NET_CLS_ACT
-        ---help---
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here if you want to do traffic policing, i.e. strict
 	  bandwidth limiting. This action replaces the existing policing
 	  module.
@@ -740,9 +740,9 @@ config NET_ACT_POLICE
 	  module will be called act_police.
 
 config NET_ACT_GACT
-        tristate "Generic actions"
-        depends on NET_CLS_ACT
-        ---help---
+	tristate "Generic actions"
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here to take generic actions such as dropping and
 	  accepting packets.
 
@@ -750,15 +750,15 @@ config NET_ACT_GACT
 	  module will be called act_gact.
 
 config GACT_PROB
-        bool "Probability support"
-        depends on NET_ACT_GACT
-        ---help---
+	bool "Probability support"
+	depends on NET_ACT_GACT
+	---help---
 	  Say Y here to use the generic action randomly or deterministically.
 
 config NET_ACT_MIRRED
-        tristate "Redirecting and Mirroring"
-        depends on NET_CLS_ACT
-        ---help---
+	tristate "Redirecting and Mirroring"
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here to allow packets to be mirrored or redirected to
 	  other devices.
 
@@ -766,10 +766,10 @@ config NET_ACT_MIRRED
 	  module will be called act_mirred.
 
 config NET_ACT_SAMPLE
-        tristate "Traffic Sampling"
-        depends on NET_CLS_ACT
-        select PSAMPLE
-        ---help---
+	tristate "Traffic Sampling"
+	depends on NET_CLS_ACT
+	select PSAMPLE
+	---help---
 	  Say Y here to allow packet sampling tc action. The packet sample
 	  action consists of statistically choosing packets and sampling
 	  them using the psample module.
@@ -778,9 +778,9 @@ config NET_ACT_SAMPLE
 	  module will be called act_sample.
 
 config NET_ACT_IPT
-        tristate "IPtables targets"
-        depends on NET_CLS_ACT && NETFILTER && IP_NF_IPTABLES
-        ---help---
+	tristate "IPtables targets"
+	depends on NET_CLS_ACT && NETFILTER && IP_NF_IPTABLES
+	---help---
 	  Say Y here to be able to invoke iptables targets after successful
 	  classification.
 
@@ -788,9 +788,9 @@ config NET_ACT_IPT
 	  module will be called act_ipt.
 
 config NET_ACT_NAT
-        tristate "Stateless NAT"
-        depends on NET_CLS_ACT
-        ---help---
+	tristate "Stateless NAT"
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here to do stateless NAT on IPv4 packets.  You should use
 	  netfilter for NAT unless you know what you are doing.
 
@@ -798,18 +798,18 @@ config NET_ACT_NAT
 	  module will be called act_nat.
 
 config NET_ACT_PEDIT
-        tristate "Packet Editing"
-        depends on NET_CLS_ACT
-        ---help---
+	tristate "Packet Editing"
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here if you want to mangle the content of packets.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called act_pedit.
 
 config NET_ACT_SIMP
-        tristate "Simple Example (Debug)"
-        depends on NET_CLS_ACT
-        ---help---
+	tristate "Simple Example (Debug)"
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here to add a simple action for demonstration purposes.
 	  It is meant as an example and for debugging purposes. It will
 	  print a configured policy string followed by the packet count
@@ -821,9 +821,9 @@ config NET_ACT_SIMP
 	  module will be called act_simple.
 
 config NET_ACT_SKBEDIT
-        tristate "SKB Editing"
-        depends on NET_CLS_ACT
-        ---help---
+	tristate "SKB Editing"
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here to change skb priority or queue_mapping settings.
 
 	  If unsure, say N.
@@ -832,10 +832,10 @@ config NET_ACT_SKBEDIT
 	  module will be called act_skbedit.
 
 config NET_ACT_CSUM
-        tristate "Checksum Updating"
-        depends on NET_CLS_ACT && INET
-        select LIBCRC32C
-        ---help---
+	tristate "Checksum Updating"
+	depends on NET_CLS_ACT && INET
+	select LIBCRC32C
+	---help---
 	  Say Y here to update some common checksum after some direct
 	  packet alterations.
 
@@ -843,9 +843,9 @@ config NET_ACT_CSUM
 	  module will be called act_csum.
 
 config NET_ACT_VLAN
-        tristate "Vlan manipulation"
-        depends on NET_CLS_ACT
-        ---help---
+	tristate "Vlan manipulation"
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here to push or pop vlan headers.
 
 	  If unsure, say N.
@@ -854,9 +854,9 @@ config NET_ACT_VLAN
 	  module will be called act_vlan.
 
 config NET_ACT_BPF
-        tristate "BPF based action"
-        depends on NET_CLS_ACT
-        ---help---
+	tristate "BPF based action"
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here to execute BPF code on packets. The BPF code will decide
 	  if the packet should be dropped or not.
 
@@ -866,10 +866,10 @@ config NET_ACT_BPF
 	  module will be called act_bpf.
 
 config NET_ACT_CONNMARK
-        tristate "Netfilter Connection Mark Retriever"
-        depends on NET_CLS_ACT && NETFILTER && IP_NF_IPTABLES
-        depends on NF_CONNTRACK && NF_CONNTRACK_MARK
-        ---help---
+	tristate "Netfilter Connection Mark Retriever"
+	depends on NET_CLS_ACT && NETFILTER && IP_NF_IPTABLES
+	depends on NF_CONNTRACK && NF_CONNTRACK_MARK
+	---help---
 	  Say Y here to allow retrieving of conn mark
 
 	  If unsure, say N.
@@ -878,33 +878,33 @@ config NET_ACT_CONNMARK
 	  module will be called act_connmark.
 
 config NET_ACT_SKBMOD
-        tristate "skb data modification action"
-        depends on NET_CLS_ACT
-        ---help---
-         Say Y here to allow modification of skb data
+	tristate "skb data modification action"
+	depends on NET_CLS_ACT
+	---help---
+	  Say Y here to allow modification of skb data
 
-         If unsure, say N.
+	  If unsure, say N.
 
-         To compile this code as a module, choose M here: the
-         module will be called act_skbmod.
+	  To compile this code as a module, choose M here: the
+	  module will be called act_skbmod.
 
 config NET_ACT_IFE
-        tristate "Inter-FE action based on IETF ForCES InterFE LFB"
-        depends on NET_CLS_ACT
-        select NET_IFE
-        ---help---
+	tristate "Inter-FE action based on IETF ForCES InterFE LFB"
+	depends on NET_CLS_ACT
+	select NET_IFE
+	---help---
 	  Say Y here to allow for sourcing and terminating metadata
 	  For details refer to netdev01 paper:
 	  "Distributing Linux Traffic Control Classifier-Action Subsystem"
-	   Authors: Jamal Hadi Salim and Damascene M. Joachimpillai
+	  Authors: Jamal Hadi Salim and Damascene M. Joachimpillai
 
 	  To compile this code as a module, choose M here: the
 	  module will be called act_ife.
 
 config NET_ACT_TUNNEL_KEY
-        tristate "IP tunnel metadata manipulation"
-        depends on NET_CLS_ACT
-        ---help---
+	tristate "IP tunnel metadata manipulation"
+	depends on NET_CLS_ACT
+	---help---
 	  Say Y here to set/release ip tunnel metadata.
 
 	  If unsure, say N.
@@ -913,16 +913,16 @@ config NET_ACT_TUNNEL_KEY
 	  module will be called act_tunnel_key.
 
 config NET_IFE_SKBMARK
-        tristate "Support to encoding decoding skb mark on IFE action"
-        depends on NET_ACT_IFE
+	tristate "Support to encoding decoding skb mark on IFE action"
+	depends on NET_ACT_IFE
 
 config NET_IFE_SKBPRIO
-        tristate "Support to encoding decoding skb prio on IFE action"
-        depends on NET_ACT_IFE
+	tristate "Support to encoding decoding skb prio on IFE action"
+	depends on NET_ACT_IFE
 
 config NET_IFE_SKBTCINDEX
-        tristate "Support to encoding decoding skb tcindex on IFE action"
-        depends on NET_ACT_IFE
+	tristate "Support to encoding decoding skb tcindex on IFE action"
+	depends on NET_ACT_IFE
 
 config NET_CLS_IND
 	bool "Incoming device classification"
diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index 4172204..9393427 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -137,25 +137,25 @@ config CFG80211_REG_RELAX_NO_IR
 	bool "cfg80211 support for NO_IR relaxation"
 	depends on CFG80211_CERTIFICATION_ONUS
 	---help---
-	 This option enables support for relaxation of the NO_IR flag for
-	 situations that certain regulatory bodies have provided clarifications
-	 on how relaxation can occur. This feature has an inherent dependency on
-	 userspace features which must have been properly tested and as such is
-	 not enabled by default.
-
-	 A relaxation feature example is allowing the operation of a P2P group
-	 owner (GO) on channels marked with NO_IR if there is an additional BSS
-	 interface which associated to an AP which userspace assumes or confirms
-	 to be an authorized master, i.e., with radar detection support and DFS
-	 capabilities. However, note that in order to not create daisy chain
-	 scenarios, this relaxation is not allowed in cases where the BSS client
-	 is associated to P2P GO and in addition the P2P GO instantiated on
-	 a channel due to this relaxation should not allow connection from
-	 non P2P clients.
-
-	 The regulatory core will apply these relaxations only for drivers that
-	 support this feature by declaring the appropriate channel flags and
-	 capabilities in their registration flow.
+	  This option enables support for relaxation of the NO_IR flag for
+	  situations that certain regulatory bodies have provided clarifications
+	  on how relaxation can occur. This feature has an inherent dependency on
+	  userspace features which must have been properly tested and as such is
+	  not enabled by default.
+
+	  A relaxation feature example is allowing the operation of a P2P group
+	  owner (GO) on channels marked with NO_IR if there is an additional BSS
+	  interface which associated to an AP which userspace assumes or confirms
+	  to be an authorized master, i.e., with radar detection support and DFS
+	  capabilities. However, note that in order to not create daisy chain
+	  scenarios, this relaxation is not allowed in cases where the BSS client
+	  is associated to P2P GO and in addition the P2P GO instantiated on
+	  a channel due to this relaxation should not allow connection from
+	  non P2P clients.
+
+	  The regulatory core will apply these relaxations only for drivers that
+	  support this feature by declaring the appropriate channel flags and
+	  capabilities in their registration flow.
 
 config CFG80211_DEFAULT_PS
 	bool "enable powersave by default"
diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 5d43aaa..5ed8b86 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -2,13 +2,13 @@
 # XFRM configuration
 #
 config XFRM
-       bool
-       depends on NET
-       select GRO_CELLS
-       select SKB_EXTENSIONS
+	bool
+	depends on NET
+	select GRO_CELLS
+	select SKB_EXTENSIONS
 
 config XFRM_OFFLOAD
-       bool
+	bool
 
 config XFRM_ALGO
 	tristate
-- 
1.9.1

