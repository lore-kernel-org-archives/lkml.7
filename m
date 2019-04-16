Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2315C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DA420818
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383640;
	bh=i4wKVAr5Hg58U+ofYW8tyuAhkCdm6qAWYxvO67eUicE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1PKt/i16teEBiyJ0LftN+McsrcnS/zn8tQf95KNpX3jO2RynzfjqRGei3HlSV7cGR
	 nJn3I1me3sYGFl/xgKdyBWvC/KAAyR3GRvXQz9GUNA1wFS9Y+FaGHusZuaAeY9jFRY
	 wwqWV+QDI+cHNspGAKMqL0OGtgwtp3MU4XZjqJ2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfDPDAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:00:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfDPC4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WqYeRSLC9EuvpodM6VNmO4HsQHOXEAoVN8mffp8BKh8=; b=XeLYFobOnycCXa19yUatArg1RJ
        e5TYTVQzjvSvV5B7/FzrkMjKpZgMreHAU+MO5h5673ZMonzpana6J73/8DWPdMbNI2qZtH9a+0RKW
        G0yfvZsH9WO+qJKhWpf6xsC9NjVUbfOszaadZzLU7USCar4LhBczyM6tlRRZP8meaW3OEJUss62B6
        1BV/yA31PMJ7JdC82lXygVRh76n3qGkddmCowpl+J3RmjuhAq0Dx2Fb5LctXIsO0pt3nNgq9BZ6Y9
        xSDKiLjFRE5RdZAdaARk6WwpEW1hGW2X3iUSmk/+1xE6fPR4DGEVWiNhns/UFny/tMHWd0vhgMEFg
        QLgpc25g==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007aL-JS; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001pi-7d; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 48/57] docs: pti_intel_mid.txt: convert to ReST
Date:   Mon, 15 Apr 2019 23:56:13 -0300
Message-Id: <10bb7a4443cb9c6e0a85f753b5ac5256d14c17f3.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert this small file to ReST format.

Most of the conversion were related to adjusting whitespaces
in order for each section to be properly parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/pti/pti_intel_mid.txt | 135 ++++++++++++++--------------
 1 file changed, 70 insertions(+), 65 deletions(-)

diff --git a/Documentation/pti/pti_intel_mid.txt b/Documentation/pti/pti_intel_mid.txt
index e7a5b6d1f7a9..a674317790ba 100644
--- a/Documentation/pti/pti_intel_mid.txt
+++ b/Documentation/pti/pti_intel_mid.txt
@@ -1,13 +1,17 @@
+=============
+Intel MID PTI
+=============
+
 The Intel MID PTI project is HW implemented in Intel Atom
 system-on-a-chip designs based on the Parallel Trace
 Interface for MIPI P1149.7 cJTAG standard.  The kernel solution
-for this platform involves the following files:
+for this platform involves the following files::
 
-./include/linux/pti.h
-./drivers/.../n_tracesink.h
-./drivers/.../n_tracerouter.c
-./drivers/.../n_tracesink.c
-./drivers/.../pti.c
+	./include/linux/pti.h
+	./drivers/.../n_tracesink.h
+	./drivers/.../n_tracerouter.c
+	./drivers/.../n_tracesink.c
+	./drivers/.../pti.c
 
 pti.c is the driver that enables various debugging features
 popular on platforms from certain mobile manufacturers.
@@ -24,13 +28,14 @@ kernel->user->kernel context switch overheads of routing
 data).
 
 An example debugging usage for this driver system:
-   *Hook /dev/ttyPTI0 to syslogd.  Opening this port will also start
+
+  * Hook /dev/ttyPTI0 to syslogd.  Opening this port will also start
     a console device to further capture debugging messages to PTI.
-   *Hook /dev/ttyPTI1 to modem debugging data to write to PTI HW.
+  * Hook /dev/ttyPTI1 to modem debugging data to write to PTI HW.
     This is where n_tracerouter and n_tracesink are used.
-   *Hook /dev/pti to a user-level debugging application for writing
+  * Hook /dev/pti to a user-level debugging application for writing
     to PTI HW.
-   *Use mipi_* Kernel Driver API in other device drivers for
+  * `Use mipi_` Kernel Driver API in other device drivers for
     debugging to PTI by first requesting a PTI write address via
     mipi_request_masterchannel(1).
 
@@ -42,58 +47,58 @@ but is not just blindly executing as 'root'. Keep in mind
 the use of ioctl(,TIOCSETD,) is not specific to the n_tracerouter
 and n_tracesink line discpline drivers but is a generic
 operation for a program to use a line discpline driver
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
-- 
2.20.1

