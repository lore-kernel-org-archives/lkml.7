Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81723C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393A1217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lnkmByke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfHYJtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 05:49:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:45813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfHYJtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566726573;
        bh=CFHECT9bG5X2IwhyGCyeIwHD0r6uYD/XCUW8ioxoR5w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lnkmBykerAKIkjNdLQcplqRJfvj3vITLYOgXVkOxqB/bCpGrL56M7D8XGx3UKT1O5
         wmDIyBtuWs0U7Mhxf2UUrgosbihzJbSbW1y6EbQsqwBdejpIE665bgZOdjSXmkdyZ/
         dka9uNAUKUv7+XF2Apedc+Zsyj6B/s5quJx/LWys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([82.19.195.159]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LfXmv-1iZF1I23FR-00p6ea; Sun, 25 Aug 2019 11:49:33 +0200
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Dewar <alex.dewar@gmx.co.uk>
Subject: [PATCH 1/4] Add SPDX headers for files in arch/um/drivers
Date:   Sun, 25 Aug 2019 10:49:16 +0100
Message-Id: <20190825094919.4731-2-alex.dewar@gmx.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825094919.4731-1-alex.dewar@gmx.co.uk>
References: <20190825094919.4731-1-alex.dewar@gmx.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gOaFSu8LHwciPiE/S9LLsyFFI2E/gaK6h+7AXVamNBAgGiDl6Mw
 CpBOUvwMlmhtzxBDnDHtNtcp7lbdqEtP6TJMZ/wJJkDoiRWmLnhDRLGVb6X/XS2BUIuu4SK
 ZY32ZqKeEQADSlApR7TUeSLE3OQdoqurH4v0t71suvpQenUVQD9NpmJEb8vVIYVZ9e3KG0b
 w1LsoEkjRlLMXXzl0gtlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C8WiAqJH790=:4zGYI7QsJY/pbomWFRgEwz
 z6mn6OSRmmul1rFmLwwmnlQGJzLWe1ntrtGjvdBFhKhIkrgqu9OHGdeY7iWJSVfrs/4orEDkb
 7S3caf80jI5h4G2W1H+9f1BX10taL+SVHnyv9OOWmoWlo0wdTRqmkrUEUrgJOnGOZMOGr8PV2
 FMWukGNylIbz/apD5ytjfXj3HU48lHZdppge5D41RNSFQ+EI+A08uDgtKnnPXDkGWEdmTJOyw
 WzBigE/eofRSPUIyNqlm4MZ1Yu32Fov/DsfRADs8vi8uFYZk0ZCfznQDUje+Nmv95djUfBem4
 WtBVx9w7escbw9T4s+Ug9JQqSF2qCBUJPlc9r1qEQ8AJQvDIrjVwZIO9pRR2Pm6EbtA51/hgU
 YsxYw++bHAOEYaBAKKIM3trV/4inSdVauK3EAXOkBoYSx+yZMFvSuLVJHnAfCMZ+bbsBoSMiE
 oj2GKO+Gl5VGbJdyrcSpcp+eT0aiKX0wR+Xj66kjtP2KckcKdBEgvSx/QgRp9dtOPYzUo4YFg
 D7shqk2pX9J4CiYbzaMLrq/jJaUuqI4uDU2Dfwguuzxj1rUdA22gdPhQw16B+DM72h0va9QBI
 agohxXUym+JXgnZXTzHCQjV4VY+sR0LOa9XGg0RPBGnqvtl/M2Gr57y/JhyrMKJopoLqkJsic
 P5JTwfRqfs9CGJT6gX0qvvSNwZo7MOCBDuuA9WHxy7vvEN9S5s0NuUAPP9hE4WMCAqCkpP+lL
 r4Q7qn2dFXwsUTkpfRJYOSi43mPS5ez7zG0alRpEV2z1MBT5exLWFPTCLE7vWiVOYl13B7OfY
 h2tv0wZXInfDuDPstAakA9NJGi2hTN6HRa02c4LTkYPZMzzZvFWnb2NRkYDmmL465nP40wgr1
 JI7a2VhjbaehaESRuZyWv/EDmY3QBADhrlcL2xn5QtovkezoA1sweRfZXK7I5fXOa7CBin/gW
 z601/w4bc3W6cpOCL36JiqHbX0B0tgVf3P7/stvldcOCbFMhRInHeWyxdI/WcItoUDtJtnvs6
 1juJvEq54/5+QrkXLBaOqkwCa6Pzf7dsrS6sEpXPUJYyeqPk+5MY63Irq2IC1gkqpS3P//cfH
 Y1W0oOoKUUzhTxrY01bsuziTloCcGfaer+jWngpQJEpYWalACPt/hwjyQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert files to use SPDX header. All files are licensed under the GPLv2.

Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
=2D--
 arch/um/drivers/Makefile            | 2 +-
 arch/um/drivers/chan.h              | 2 +-
 arch/um/drivers/chan_kern.c         | 2 +-
 arch/um/drivers/chan_user.c         | 2 +-
 arch/um/drivers/chan_user.h         | 2 +-
 arch/um/drivers/cow_user.c          | 2 +-
 arch/um/drivers/daemon.h            | 2 +-
 arch/um/drivers/daemon_kern.c       | 2 +-
 arch/um/drivers/daemon_user.c       | 2 +-
 arch/um/drivers/fd.c                | 2 +-
 arch/um/drivers/harddog_user.c      | 2 +-
 arch/um/drivers/hostaudio_kern.c    | 2 +-
 arch/um/drivers/line.c              | 2 +-
 arch/um/drivers/line.h              | 2 +-
 arch/um/drivers/mconsole.h          | 2 +-
 arch/um/drivers/mconsole_kern.c     | 2 +-
 arch/um/drivers/mconsole_kern.h     | 2 +-
 arch/um/drivers/mconsole_user.c     | 2 +-
 arch/um/drivers/net_kern.c          | 2 +-
 arch/um/drivers/net_user.c          | 2 +-
 arch/um/drivers/null.c              | 2 +-
 arch/um/drivers/pcap_kern.c         | 2 +-
 arch/um/drivers/pcap_user.c         | 2 +-
 arch/um/drivers/pcap_user.h         | 2 +-
 arch/um/drivers/port.h              | 2 +-
 arch/um/drivers/port_kern.c         | 2 +-
 arch/um/drivers/port_user.c         | 2 +-
 arch/um/drivers/pty.c               | 2 +-
 arch/um/drivers/slip_kern.c         | 2 +-
 arch/um/drivers/slip_user.c         | 2 +-
 arch/um/drivers/slirp_kern.c        | 2 +-
 arch/um/drivers/slirp_user.c        | 2 +-
 arch/um/drivers/ssl.c               | 2 +-
 arch/um/drivers/stdio_console.c     | 2 +-
 arch/um/drivers/stdio_console.h     | 2 +-
 arch/um/drivers/tty.c               | 2 +-
 arch/um/drivers/ubd.h               | 2 +-
 arch/um/drivers/ubd_kern.c          | 2 +-
 arch/um/drivers/ubd_user.c          | 2 +-
 arch/um/drivers/umcast.h            | 2 +-
 arch/um/drivers/umcast_kern.c       | 2 +-
 arch/um/drivers/umcast_user.c       | 2 +-
 arch/um/drivers/vde.h               | 2 +-
 arch/um/drivers/vde_kern.c          | 2 +-
 arch/um/drivers/vde_user.c          | 2 +-
 arch/um/drivers/vector_kern.c       | 2 +-
 arch/um/drivers/vector_kern.h       | 2 +-
 arch/um/drivers/vector_transports.c | 2 +-
 arch/um/drivers/vector_user.c       | 2 +-
 arch/um/drivers/vector_user.h       | 2 +-
 arch/um/drivers/xterm.c             | 2 +-
 arch/um/drivers/xterm.h             | 2 +-
 arch/um/drivers/xterm_kern.c        | 2 +-
 53 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 693319839f69..84d6f6e42c3a 100644
=2D-- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (C) 2000, 2002, 2003 Jeff Dike (jdike@karaya.com)
-# Licensed under the GPL
 #

 # pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
diff --git a/arch/um/drivers/chan.h b/arch/um/drivers/chan.h
index c512b0306dd4..c37cc4f26f91 100644
=2D-- a/arch/um/drivers/chan.h
+++ b/arch/um/drivers/chan.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #ifndef __CHAN_KERN_H__
diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 749d2bf59599..62997055c454 100644
=2D-- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
  */

 #include <linux/slab.h>
diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 3fd7c3efdb18..4d80526a4236 100644
=2D-- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
  */

 #include <stdlib.h>
diff --git a/arch/um/drivers/chan_user.h b/arch/um/drivers/chan_user.h
index 03f1b565c5f9..72222bb036f5 100644
=2D-- a/arch/um/drivers/chan_user.h
+++ b/arch/um/drivers/chan_user.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #ifndef __CHAN_USER_H__
diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index 0ee9cc6cc4c7..74b0c2686c95 100644
=2D-- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
  */

 /*
diff --git a/arch/um/drivers/daemon.h b/arch/um/drivers/daemon.h
index c2dd1951559f..1509cc7eb907 100644
=2D-- a/arch/um/drivers/daemon.h
+++ b/arch/um/drivers/daemon.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #ifndef __DAEMON_H__
diff --git a/arch/um/drivers/daemon_kern.c b/arch/um/drivers/daemon_kern.c
index 7568cc2f3cd6..fd2402669c49 100644
=2D-- a/arch/um/drivers/daemon_kern.c
+++ b/arch/um/drivers/daemon_kern.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
  * James Leu (jleu@mindspring.net).
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Copyright (C) 2001 by various other people who didn't put their name h=
ere.
- * Licensed under the GPL.
  */

 #include <linux/init.h>
diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
index 8813c10d0177..3695821d06a2 100644
=2D-- a/arch/um/drivers/daemon_user.c
+++ b/arch/um/drivers/daemon_user.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
  * James Leu (jleu@mindspring.net).
  * Copyright (C) 2001 by various other people who didn't put their name h=
ere.
- * Licensed under the GPL.
  */

 #include <stdint.h>
diff --git a/arch/um/drivers/fd.c b/arch/um/drivers/fd.c
index a13a427b996b..082d739dc052 100644
=2D-- a/arch/um/drivers/fd.c
+++ b/arch/um/drivers/fd.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/drivers/harddog_user.c b/arch/um/drivers/harddog_user=
.c
index 3aa8b0d52a48..070468d22e39 100644
=2D-- a/arch/um/drivers/harddog_user.c
+++ b/arch/um/drivers/harddog_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_=
kern.c
index 7f9dbdbc4eb7..bf75b1ceac47 100644
=2D-- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 Steve Schmidtke
- * Licensed under the GPL
  */

 #include <linux/fs.h>
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index e0e63931fb2b..4f2a4ac8a82b 100644
=2D-- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/irqreturn.h>
diff --git a/arch/um/drivers/line.h b/arch/um/drivers/line.h
index 138a14526d9c..a151ff5155ef 100644
=2D-- a/arch/um/drivers/line.h
+++ b/arch/um/drivers/line.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #ifndef __LINE_H__
diff --git a/arch/um/drivers/mconsole.h b/arch/um/drivers/mconsole.h
index 44af7379ea19..6356378304fd 100644
=2D-- a/arch/um/drivers/mconsole.h
+++ b/arch/um/drivers/mconsole.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org)
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #ifndef __MCONSOLE_H__
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_ke=
rn.c
index ff3ab72fd90f..0117489e9b30 100644
=2D-- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org)
  * Copyright (C) 2001 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/console.h>
diff --git a/arch/um/drivers/mconsole_kern.h b/arch/um/drivers/mconsole_ke=
rn.h
index 7a0c6a1ad1d4..56d8d6a3ff76 100644
=2D-- a/arch/um/drivers/mconsole_kern.h
+++ b/arch/um/drivers/mconsole_kern.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #ifndef __MCONSOLE_KERN_H__
diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_us=
er.c
index 99209826adb1..e24298a734be 100644
=2D-- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org)
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <errno.h>
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 6e5be5fb4143..327b728f7244 100644
=2D-- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
  * James Leu (jleu@mindspring.net).
  * Copyright (C) 2001 by various other people who didn't put their name h=
ere.
- * Licensed under the GPL.
  */

 #include <linux/memblock.h>
diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index e9f8445861dc..4c9576452ab0 100644
=2D-- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/drivers/null.c b/arch/um/drivers/null.c
index 10495747ce8e..87087763a417 100644
=2D-- a/arch/um/drivers/null.c
+++ b/arch/um/drivers/null.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
  */

 #include <stddef.h>
diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
index be0fb57bd1d7..cfe4cb17694c 100644
=2D-- a/arch/um/drivers/pcap_kern.c
+++ b/arch/um/drivers/pcap_kern.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL.
  */

 #include <linux/init.h>
diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
index c07b9c752c86..bbd20638788a 100644
=2D-- a/arch/um/drivers/pcap_user.c
+++ b/arch/um/drivers/pcap_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL.
  */

 #include <errno.h>
diff --git a/arch/um/drivers/pcap_user.h b/arch/um/drivers/pcap_user.h
index 1ca7c764cc63..216246f5f09b 100644
=2D-- a/arch/um/drivers/pcap_user.h
+++ b/arch/um/drivers/pcap_user.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #include <net_user.h>
diff --git a/arch/um/drivers/port.h b/arch/um/drivers/port.h
index 372a80c0556a..9085b336e683 100644
=2D-- a/arch/um/drivers/port.h
+++ b/arch/um/drivers/port.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #ifndef __PORT_H__
diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index b0e9ff35daee..a47ca5376d9d 100644
=2D-- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
  */

 #include <linux/completion.h>
diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index 5f56d11b886f..5b5b64cb1071 100644
=2D-- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/drivers/pty.c b/arch/um/drivers/pty.c
index f1fcc2cedb5e..39c60068cfdf 100644
=2D-- a/arch/um/drivers/pty.c
+++ b/arch/um/drivers/pty.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/drivers/slip_kern.c b/arch/um/drivers/slip_kern.c
index ed5249fc0574..c58ccdcc16d6 100644
=2D-- a/arch/um/drivers/slip_kern.c
+++ b/arch/um/drivers/slip_kern.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL.
  */

 #include <linux/if_arp.h>
diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
index 0d6b66c64a81..8016d32b6809 100644
=2D-- a/arch/um/drivers/slip_user.c
+++ b/arch/um/drivers/slip_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL.
  */

 #include <stdio.h>
diff --git a/arch/um/drivers/slirp_kern.c b/arch/um/drivers/slirp_kern.c
index 4ef11ca7cacf..2d9769237f08 100644
=2D-- a/arch/um/drivers/slirp_kern.c
+++ b/arch/um/drivers/slirp_kern.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL.
  */

 #include <linux/if_arp.h>
diff --git a/arch/um/drivers/slirp_user.c b/arch/um/drivers/slirp_user.c
index 98b6a41a254e..8f633e2e5f3d 100644
=2D-- a/arch/um/drivers/slirp_user.c
+++ b/arch/um/drivers/slirp_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL.
  */

 #include <unistd.h>
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index 7ae407d5337e..b213201b8a3b 100644
=2D-- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #include <linux/fs.h>
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_conso=
le.c
index c90817b04da9..0021d7ffb528 100644
=2D-- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #include <linux/posix_types.h>
diff --git a/arch/um/drivers/stdio_console.h b/arch/um/drivers/stdio_conso=
le.h
index 6d8275f71fd4..3a409ec23d63 100644
=2D-- a/arch/um/drivers/stdio_console.h
+++ b/arch/um/drivers/stdio_console.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #ifndef __STDIO_CONSOLE_H
diff --git a/arch/um/drivers/tty.c b/arch/um/drivers/tty.c
index eaa201bca5ed..884a762d21c7 100644
=2D-- a/arch/um/drivers/tty.c
+++ b/arch/um/drivers/tty.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
  */

 #include <errno.h>
diff --git a/arch/um/drivers/ubd.h b/arch/um/drivers/ubd.h
index cc1cc85f5afc..f016fe15499f 100644
=2D-- a/arch/um/drivers/ubd.h
+++ b/arch/um/drivers/ubd.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Copyright (C) 2001 RidgeRun, Inc (glonnon@ridgerun.com)
- * Licensed under the GPL
  */

 #ifndef __UM_UBD_USER_H
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 33c1cd6a12ac..612535cd9706 100644
=2D-- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1,8 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2018 Cambridge Greys Ltd
  * Copyright (C) 2015-2016 Anton Ivanov (aivanov@brocade.com)
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 /* 2001-09-28...2002-04-17
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index 6f744794d141..a1afe414ce48 100644
=2D-- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -1,8 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 Anton Ivanov (aivanov@brocade.com)
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Copyright (C) 2001 Ridgerun,Inc (glonnon@ridgerun.com)
- * Licensed under the GPL
  */

 #include <stddef.h>
diff --git a/arch/um/drivers/umcast.h b/arch/um/drivers/umcast.h
index c190c6440911..fe39bee1e3bd 100644
=2D-- a/arch/um/drivers/umcast.h
+++ b/arch/um/drivers/umcast.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #ifndef __DRIVERS_UMCAST_H
diff --git a/arch/um/drivers/umcast_kern.c b/arch/um/drivers/umcast_kern.c
index f5ba6e377913..595a54f2b9c6 100644
=2D-- a/arch/um/drivers/umcast_kern.c
+++ b/arch/um/drivers/umcast_kern.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * user-mode-linux networking multicast transport
  * Copyright (C) 2001 by Harald Welte <laforge@gnumonks.org>
@@ -8,7 +9,6 @@
  * James Leu (jleu@mindspring.net).
  * Copyright (C) 2001 by various other people who didn't put their name h=
ere.
  *
- * Licensed under the GPL.
  */

 #include <linux/init.h>
diff --git a/arch/um/drivers/umcast_user.c b/arch/um/drivers/umcast_user.c
index 6074184bb51b..b50b13cff04e 100644
=2D-- a/arch/um/drivers/umcast_user.c
+++ b/arch/um/drivers/umcast_user.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * user-mode-linux networking multicast transport
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
@@ -8,7 +9,6 @@
  * James Leu (jleu@mindspring.net).
  * Copyright (C) 2001 by various other people who didn't put their name h=
ere.
  *
- * Licensed under the GPL.
  *
  */

diff --git a/arch/um/drivers/vde.h b/arch/um/drivers/vde.h
index fc3a05902ba1..cab0379e6142 100644
=2D-- a/arch/um/drivers/vde.h
+++ b/arch/um/drivers/vde.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2007 Luca Bigliardi (shammash@artha.org).
- * Licensed under the GPL.
  */

 #ifndef __UM_VDE_H__
diff --git a/arch/um/drivers/vde_kern.c b/arch/um/drivers/vde_kern.c
index 6a365fadc7c4..bc6f22cbfb35 100644
=2D-- a/arch/um/drivers/vde_kern.c
+++ b/arch/um/drivers/vde_kern.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Luca Bigliardi (shammash@artha.org).
- * Licensed under the GPL.
  *
  * Transport usage:
  *  ethN=3Dvde,<vde_switch>,<mac addr>,<port>,<group>,<mode>,<description=
>
diff --git a/arch/um/drivers/vde_user.c b/arch/um/drivers/vde_user.c
index 64cb630d1157..bc7dc4e1e486 100644
=2D-- a/arch/um/drivers/vde_user.c
+++ b/arch/um/drivers/vde_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Luca Bigliardi (shammash@artha.org).
- * Licensed under the GPL.
  */

 #include <stddef.h>
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index e190e4ca52e1..423928fc68f0 100644
=2D-- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 - Cambridge Greys Limited
  * Copyright (C) 2011 - 2014 Cisco Systems Inc
@@ -5,7 +6,6 @@
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
  * James Leu (jleu@mindspring.net).
  * Copyright (C) 2001 by various other people who didn't put their name h=
ere.
- * Licensed under the GPL.
  */

 #include <linux/version.h>
diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
index 0b0a767b9076..648c1890f723 100644
=2D-- a/arch/um/drivers/vector_kern.h
+++ b/arch/um/drivers/vector_kern.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2002 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #ifndef __UM_VECTOR_KERN_H
diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_=
transports.c
index 77e4ebc206ae..7675f8cdcfa1 100644
=2D-- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 - Cambridge Greys Limited
  * Copyright (C) 2011 - 2014 Cisco Systems Inc
- * Licensed under the GPL.
  */

 #include <linux/etherdevice.h>
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index b3f7b3ca896d..339c71c4537d 100644
=2D-- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index d7cbff73b7ff..0bc34e0c8cba 100644
=2D-- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2002 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #ifndef __UM_VECTOR_USER_H
diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index 20e30be44795..fc7f1e746703 100644
=2D-- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stddef.h>
diff --git a/arch/um/drivers/xterm.h b/arch/um/drivers/xterm.h
index 56b9c4aba423..5968da3a6aba 100644
=2D-- a/arch/um/drivers/xterm.h
+++ b/arch/um/drivers/xterm.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
  */

 #ifndef __XTERM_H__
diff --git a/arch/um/drivers/xterm_kern.c b/arch/um/drivers/xterm_kern.c
index e8f9957bfbf6..d64ef6d0d463 100644
=2D-- a/arch/um/drivers/xterm_kern.c
+++ b/arch/um/drivers/xterm_kern.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/slab.h>
=2D-
2.23.0

