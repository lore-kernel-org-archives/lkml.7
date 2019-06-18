Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491A7C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153A221655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891254;
	bh=cpCxZYmen5R5Qr/wOYufgaUa67IPs9GMeeOhz2GH/Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDkR/nuOPjI5VQBuPbj/sjcVusclny7Lo67wkKh04Cp+C3sWg5NqB+TfabrSdO4eD
	 fqWBqoSB4mEfGKO4bDXHK9hguyvY2IM32ppwFwkounSW1NiscPBXNrBtanScZbF1UB
	 IQjOPvgwYrhvZGyBJ69Rq1Wp6cZMyKe6bBWSyJg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfFRUyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:54:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbfFRUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eones6QuDT9PdWjV+tkuB9RT4tJAbIFaVBOMCYjookk=; b=M1rqmtQIrdKSFwD2BYCXqZ9tU9
        DR50IPRkzzZlNmlASh5/E/ipDLQqHdgQLyzA6zouoovQA1+XHc7ZrY/XobvvMXdhjsxuDJIAQ7w38
        /s6iGJ1ID4McnQTryGq+E3r3IMdffMfWRuR1Vh/Jn0FDP7ckLco5sKAy20fH4nvEi5dTCLnvvitfP
        MiXM9YcPyw0y1ox6Gfu4jPgBpuE5JkgssijJLtnDY2+2n7/orfFep3Hq5zFTG6gfU04B7kJJVWU4u
        CQNjdG1vGU06Ji8PBDysdeP1YWoizGu4dpoarqJzqt8xeUVPspXaYW8eZ06ITE4DPxIyMm+KyIQ8A
        rn1h4B+g==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL77-0008Sl-Tm; Tue, 18 Jun 2019 20:53:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL6z-0001zI-Q0; Tue, 18 Jun 2019 17:53:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 07/29] docs: pti_intel_mid.txt: convert it to pti_intel_mid.rst
Date:   Tue, 18 Jun 2019 17:53:25 -0300
Message-Id: <8700e4276022bc1f920f1d2481d71619d60d5bff.1560890800.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
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

