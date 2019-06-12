Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA71C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA07217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364875;
	bh=cpCxZYmen5R5Qr/wOYufgaUa67IPs9GMeeOhz2GH/Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KsB0DR/U/6afkLdIDsIVGhG4dbJDbrkG0f2SOyErZUrYqWc6aIRmd39d7oBXY3nnm
	 RV5RWdd+1w6+8cOudOTbEPhZ7ZI07snYx5fxA6+z4D5tlsXsErwwkNlwtfud/+nWnu
	 Iu1gcJnTsSBBdALr0XcsMFtOOkaTG66UfVNI8bjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfFLSlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:41:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfFLSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eones6QuDT9PdWjV+tkuB9RT4tJAbIFaVBOMCYjookk=; b=Qgltymsi0tqlWbU+/ut40jz3t+
        qIKY83OB8STwfad9Yp2s/GMZXMvBO4828c1+2Vz9LJyVWx3GLzaKDR/Q1tmypIeXfG11DEcSYgkxt
        eIzc6AfMhBqEP+U4PnaY8UrwddBg6Ng8XTtWZb+aXwIOUJczoEEYF/K18tCM8s45e3DbzZpvYnCam
        TTWQRkfHRZ94OUa1/cbTsZbhGlLssMpXCnOtzUSAqTgamqW4JkA3uy8UsHrFhDhsYlZhlou2vHw5L
        DLPePst8qN+wIPIN1ahAtRLVRL8tazLhDIGdn/c7dk1MwY5isO45dy1ntBascNemnqSH5a3zSb0QL
        A4zWNhyw==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YJ-IM; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88p-0002Ah-V1; Wed, 12 Jun 2019 15:38:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 07/31] docs: pti_intel_mid.txt: convert it to pti_intel_mid.rst
Date:   Wed, 12 Jun 2019 15:38:10 -0300
Message-Id: <bb3a4561c254124289eaf4b318a0825f72d0d8b2.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
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

