Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2832FC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2566208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724640;
	bh=cpCxZYmen5R5Qr/wOYufgaUa67IPs9GMeeOhz2GH/Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fRrxLUVCZwf0WB3/+jeYzrvO8AHw3oM2M6MI4uB0wuoMwJaLSjjFXP+l9cOXttncf
	 bCmLo8TsX6tZDbPjyqE1btSXrmJTPMnkblv9wtuzUQ5gM3LOGKa7Lire5vaBiBdoDf
	 ZxD5LRV378uJTN2Mn6iqK3SCeNNWc9GLct4/+Pqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfF1MX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:23:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1MUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eones6QuDT9PdWjV+tkuB9RT4tJAbIFaVBOMCYjookk=; b=hOY4zuwVKhEv/QWGI1NFQ7Em7K
        YzuHUDODwrVEMRO1SFkiRJ88SAoJ/RB3hA+LeW3ChA3auyZVBvbbfq/oNqvSXAuOGeqI3XNpy1h0b
        0P0Fw1n5AY8Xcm3nOqsJiejzHWljEcFSItfa+K9ZGQ+FBGOqazAzaWJn0W8ZwNcmuozZUNZv/JrEr
        jAhRHISmHnmxigq58aJE3zzokeVPLfNAO9G/tLjY/RbJH2uixR6JBOyVOhhhxhaPk7F85ChupySZE
        SAVZ2SGye32yRcG4dRoTr+K1+83alPWKV6HWfFAft77Am6Jg2phfmG6ZIkxhVpFQy1XcaQ23hnv2E
        zvKw+tzg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-00009z-7Q; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-00057k-BQ; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 12/43] docs: pti_intel_mid.txt: convert it to pti_intel_mid.rst
Date:   Fri, 28 Jun 2019 09:20:08 -0300
Message-Id: <ef0dc0015005339a1698a918a37b02663f29efaf.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert this small file to ReST format and rename it.

Most of the conversion were related to adjusting whitespaces
in order for each section to be properly parsed.

While this is not part of any book, mark it as :orphan:, in order
to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/pti/pti_intel_mid.rst | 106 ++++++++++++++++++++++++++++
 Documentation/pti/pti_intel_mid.txt |  99 --------------------------
 2 files changed, 106 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/pti/pti_intel_mid.rst
 delete mode 100644 Documentation/pti/pti_intel_mid.txt

diff --git a/Documentation/pti/pti_intel_mid.rst b/Documentation/pti/pti_intel_mid.rst
new file mode 100644
index 000000000000..ea05725174cb
--- /dev/null
+++ b/Documentation/pti/pti_intel_mid.rst
@@ -0,0 +1,106 @@
+:orphan:
+
+=============
+Intel MID PTI
+=============
+
+The Intel MID PTI project is HW implemented in Intel Atom
+system-on-a-chip designs based on the Parallel Trace
+Interface for MIPI P1149.7 cJTAG standard.  The kernel solution
+for this platform involves the following files::
+
+	./include/linux/pti.h
+	./drivers/.../n_tracesink.h
+	./drivers/.../n_tracerouter.c
+	./drivers/.../n_tracesink.c
+	./drivers/.../pti.c
+
+pti.c is the driver that enables various debugging features
+popular on platforms from certain mobile manufacturers.
+n_tracerouter.c and n_tracesink.c allow extra system information to
+be collected and routed to the pti driver, such as trace
+debugging data from a modem.  Although n_tracerouter
+and n_tracesink are a part of the complete PTI solution,
+these two line disciplines can work separately from
+pti.c and route any data stream from one /dev/tty node
+to another /dev/tty node via kernel-space.  This provides
+a stable, reliable connection that will not break unless
+the user-space application shuts down (plus avoids
+kernel->user->kernel context switch overheads of routing
+data).
+
+An example debugging usage for this driver system:
+
+  * Hook /dev/ttyPTI0 to syslogd.  Opening this port will also start
+    a console device to further capture debugging messages to PTI.
+  * Hook /dev/ttyPTI1 to modem debugging data to write to PTI HW.
+    This is where n_tracerouter and n_tracesink are used.
+  * Hook /dev/pti to a user-level debugging application for writing
+    to PTI HW.
+  * `Use mipi_` Kernel Driver API in other device drivers for
+    debugging to PTI by first requesting a PTI write address via
+    mipi_request_masterchannel(1).
+
+Below is example pseudo-code on how a 'privileged' application
+can hook up n_tracerouter and n_tracesink to any tty on
+a system.  'Privileged' means the application has enough
+privileges to successfully manipulate the ldisc drivers
+but is not just blindly executing as 'root'. Keep in mind
+the use of ioctl(,TIOCSETD,) is not specific to the n_tracerouter
+and n_tracesink line discpline drivers but is a generic
+operation for a program to use a line discpline driver
+on a tty port other than the default n_tty::
+
+  /////////// To hook up n_tracerouter and n_tracesink /////////
+
+  // Note that n_tracerouter depends on n_tracesink.
+  #include <errno.h>
+  #define ONE_TTY "/dev/ttyOne"
+  #define TWO_TTY "/dev/ttyTwo"
+
+  // needed global to hand onto ldisc connection
+  static int g_fd_source = -1;
+  static int g_fd_sink  = -1;
+
+  // these two vars used to grab LDISC values from loaded ldisc drivers
+  // in OS.  Look at /proc/tty/ldiscs to get the right numbers from
+  // the ldiscs loaded in the system.
+  int source_ldisc_num, sink_ldisc_num = -1;
+  int retval;
+
+  g_fd_source = open(ONE_TTY, O_RDWR); // must be R/W
+  g_fd_sink   = open(TWO_TTY, O_RDWR); // must be R/W
+
+  if (g_fd_source <= 0) || (g_fd_sink <= 0) {
+     // doubt you'll want to use these exact error lines of code
+     printf("Error on open(). errno: %d\n",errno);
+     return errno;
+  }
+
+  retval = ioctl(g_fd_sink, TIOCSETD, &sink_ldisc_num);
+  if (retval < 0) {
+     printf("Error on ioctl().  errno: %d\n", errno);
+     return errno;
+  }
+
+  retval = ioctl(g_fd_source, TIOCSETD, &source_ldisc_num);
+  if (retval < 0) {
+     printf("Error on ioctl().  errno: %d\n", errno);
+     return errno;
+  }
+
+  /////////// To disconnect n_tracerouter and n_tracesink ////////
+
+  // First make sure data through the ldiscs has stopped.
+
+  // Second, disconnect ldiscs.  This provides a
+  // little cleaner shutdown on tty stack.
+  sink_ldisc_num = 0;
+  source_ldisc_num = 0;
+  ioctl(g_fd_uart, TIOCSETD, &sink_ldisc_num);
+  ioctl(g_fd_gadget, TIOCSETD, &source_ldisc_num);
+
+  // Three, program closes connection, and cleanup:
+  close(g_fd_uart);
+  close(g_fd_gadget);
+  g_fd_uart = g_fd_gadget = NULL;
diff --git a/Documentation/pti/pti_intel_mid.txt b/Documentation/pti/pti_intel_mid.txt
deleted file mode 100644
index e7a5b6d1f7a9..000000000000
--- a/Documentation/pti/pti_intel_mid.txt
+++ /dev/null
@@ -1,99 +0,0 @@
-The Intel MID PTI project is HW implemented in Intel Atom
-system-on-a-chip designs based on the Parallel Trace
-Interface for MIPI P1149.7 cJTAG standard.  The kernel solution
-for this platform involves the following files:
-
-./include/linux/pti.h
-./drivers/.../n_tracesink.h
-./drivers/.../n_tracerouter.c
-./drivers/.../n_tracesink.c
-./drivers/.../pti.c
-
-pti.c is the driver that enables various debugging features
-popular on platforms from certain mobile manufacturers.
-n_tracerouter.c and n_tracesink.c allow extra system information to
-be collected and routed to the pti driver, such as trace
-debugging data from a modem.  Although n_tracerouter
-and n_tracesink are a part of the complete PTI solution,
-these two line disciplines can work separately from
-pti.c and route any data stream from one /dev/tty node
-to another /dev/tty node via kernel-space.  This provides
-a stable, reliable connection that will not break unless
-the user-space application shuts down (plus avoids
-kernel->user->kernel context switch overheads of routing
-data).
-
-An example debugging usage for this driver system:
-   *Hook /dev/ttyPTI0 to syslogd.  Opening this port will also start
-    a console device to further capture debugging messages to PTI.
-   *Hook /dev/ttyPTI1 to modem debugging data to write to PTI HW.
-    This is where n_tracerouter and n_tracesink are used.
-   *Hook /dev/pti to a user-level debugging application for writing
-    to PTI HW.
-   *Use mipi_* Kernel Driver API in other device drivers for
-    debugging to PTI by first requesting a PTI write address via
-    mipi_request_masterchannel(1).
-
-Below is example pseudo-code on how a 'privileged' application
-can hook up n_tracerouter and n_tracesink to any tty on
-a system.  'Privileged' means the application has enough
-privileges to successfully manipulate the ldisc drivers
-but is not just blindly executing as 'root'. Keep in mind
-the use of ioctl(,TIOCSETD,) is not specific to the n_tracerouter
-and n_tracesink line discpline drivers but is a generic
-operation for a program to use a line discpline driver
-on a tty port other than the default n_tty.
-
-/////////// To hook up n_tracerouter and n_tracesink /////////
-
-// Note that n_tracerouter depends on n_tracesink.
-#include <errno.h>
-#define ONE_TTY "/dev/ttyOne"
-#define TWO_TTY "/dev/ttyTwo"
-
-// needed global to hand onto ldisc connection
-static int g_fd_source = -1;
-static int g_fd_sink  = -1;
-
-// these two vars used to grab LDISC values from loaded ldisc drivers
-// in OS.  Look at /proc/tty/ldiscs to get the right numbers from
-// the ldiscs loaded in the system.
-int source_ldisc_num, sink_ldisc_num = -1;
-int retval;
-
-g_fd_source = open(ONE_TTY, O_RDWR); // must be R/W
-g_fd_sink   = open(TWO_TTY, O_RDWR); // must be R/W
-
-if (g_fd_source <= 0) || (g_fd_sink <= 0) {
-   // doubt you'll want to use these exact error lines of code
-   printf("Error on open(). errno: %d\n",errno);
-   return errno;
-}
-
-retval = ioctl(g_fd_sink, TIOCSETD, &sink_ldisc_num);
-if (retval < 0) {
-   printf("Error on ioctl().  errno: %d\n", errno);
-   return errno;
-}
-
-retval = ioctl(g_fd_source, TIOCSETD, &source_ldisc_num);
-if (retval < 0) {
-   printf("Error on ioctl().  errno: %d\n", errno);
-   return errno;
-}
-
-/////////// To disconnect n_tracerouter and n_tracesink ////////
-
-// First make sure data through the ldiscs has stopped.
-
-// Second, disconnect ldiscs.  This provides a
-// little cleaner shutdown on tty stack.
-sink_ldisc_num = 0;
-source_ldisc_num = 0;
-ioctl(g_fd_uart, TIOCSETD, &sink_ldisc_num);
-ioctl(g_fd_gadget, TIOCSETD, &source_ldisc_num);
-
-// Three, program closes connection, and cleanup:
-close(g_fd_uart);
-close(g_fd_gadget);
-g_fd_uart = g_fd_gadget = NULL;
-- 
2.21.0

