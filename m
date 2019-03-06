Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C23C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F45820661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfCFVPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:15:10 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:36631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfCFVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:15:10 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKsax-1hMsgx0Umr-00LBa1; Wed, 06 Mar 2019 22:14:58 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org
Subject: [PATCH v2] arch: um: Kconfig: pedantic indention cleanups
Date:   Wed,  6 Mar 2019 22:14:55 +0100
Message-Id: <1551906895-6065-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <31062067.NyzppZ7ELz@blindfold>
References: <31062067.NyzppZ7ELz@blindfold>
X-Provags-ID: V03:K1:caS+n5r7nsIZ6fTWzSWB09pXEE4MfNgocRPwZKAQw6LOK7aOgBq
 OR1Nlx5NEbGmM/T0UB5WzOg7vKblrVWWSgcoMU8IpsoGRPed04KaG+EDhBU3en87rAkjNCp
 AZKJO7p/9LusbgPiMjoxCzkuFo6ca9XrvAQ0/dsytHKE9sMcUYgbWEz4/C63fqD8hzPcx8O
 ydnG3OAVPW1MODKYJQ2Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n1hbcW0Cr+8=:SpssrzcZoZ7axS1ryXGFU6
 Lo2vdZz88ecpI3rMXLDwz1WhiCEHdg0EoaCXCxq9x01H0PpZbMUheBI7aVj/5fFp3o+oEli+a
 PZdefVA5pxgr5S+BwDnp4lsnpxaYwgryvKZIyHbAdtx5V4SG29KXd0rWMezHxShOVEWcj3hJx
 FuQg2P4rHh9t0si8pqEmRtsgXzOY6/89X1mA8cS7lcREcEy/UUOM4W2xHuNm0SBP+EjlXzAJz
 CNQsDatBGgLAGCDOMc/HEjCy5JjcSbcHSaQm0ZOcrnoJvcBEb22c3mXnBKIjf+T2v1DolnXYK
 RLfnKXoqMPCEwNddpNBG+dNlB6UaTbV4w//f9eA1xKcTrV7ENTAYMupKl7mKz39KnjX17bHW+
 qicBIw7TTjwXg8iRKrEiooIVPnKVfDbgQ1OxNMFkayuGItB8cctWvcnGqV/HzbF8lyPT72BP7
 cQIPhXgc68mpO282/kdDcPO2mkVLB39KdwbsjclZsFU3+B78Rc7tZhV3CKNiCG65nIzFoVhAm
 CL5DfTbEgyyZdP7hqrMYNzapxoDzcKTLGW9ivMAk3AGy9GtzHZm0oZgVGbCyRXr5S/d0hUe0y
 oYzBOOOl0sGqQrt8xauJ5oGD21EeH0zaaUJ4fziqi0Al6L5NwrXlQ08eerz2/cGcGgZfkWYXt
 43GouRaJLCpWrbbWqMWRAGWzPFllWP8VoaXfSSkHvopalrqQiFjh0l8eHehNHF3JUdyCf7fXc
 1ED/9u+l4GrlWHnqnu9gUava7+SXLEPm+oe3uQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/um/Kconfig | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ec9711d..216ee50 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -80,46 +80,46 @@ config LD_SCRIPT_DYN
 	bool
 	default y
 	depends on !LD_SCRIPT_STATIC
-        select MODULE_REL_CRCS if MODVERSIONS
+	select MODULE_REL_CRCS if MODVERSIONS
 
 config HOSTFS
 	tristate "Host filesystem"
 	help
-          While the User-Mode Linux port uses its own root file system for
-          booting and normal file access, this module lets the UML user
-          access files stored on the host.  It does not require any
-          network connection between the Host and UML.  An example use of
-          this might be:
+	  While the User-Mode Linux port uses its own root file system for
+	  booting and normal file access, this module lets the UML user
+	  access files stored on the host.  It does not require any
+	  network connection between the Host and UML.  An example use of
+	  this might be:
 
-          mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
+	  mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
 
-          where /tmp/fromhost is an empty directory inside UML and
-          /tmp/umlshare is a directory on the host with files the UML user
-          wishes to access.
+	  where /tmp/fromhost is an empty directory inside UML and
+	  /tmp/umlshare is a directory on the host with files the UML user
+	  wishes to access.
 
-          For more information, see
-          <http://user-mode-linux.sourceforge.net/hostfs.html>.
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/hostfs.html>.
 
-          If you'd like to be able to work with files stored on the host,
-          say Y or M here; otherwise say N.
+	  If you'd like to be able to work with files stored on the host,
+	  say Y or M here; otherwise say N.
 
 config MCONSOLE
 	bool "Management console"
 	depends on PROC_FS
 	default y
 	help
-          The user mode linux management console is a low-level interface to
-          the kernel, somewhat like the i386 SysRq interface.  Since there is
-          a full-blown operating system running under every user mode linux
-          instance, there is much greater flexibility possible than with the
-          SysRq mechanism.
-
-          If you answer 'Y' to this option, to use this feature, you need the
-          mconsole client (called uml_mconsole) which is present in CVS in
-          2.4.5-9um and later (path /tools/mconsole), and is also in the
-          distribution RPM package in 2.4.6 and later.
-
-          It is safe to say 'Y' here.
+	  The user mode linux management console is a low-level interface to
+	  the kernel, somewhat like the i386 SysRq interface.  Since there is
+	  a full-blown operating system running under every user mode linux
+	  instance, there is much greater flexibility possible than with the
+	  SysRq mechanism.
+
+	  If you answer 'Y' to this option, to use this feature, you need the
+	  mconsole client (called uml_mconsole) which is present in CVS in
+	  2.4.5-9um and later (path /tools/mconsole), and is also in the
+	  distribution RPM package in 2.4.6 and later.
+
+	  It is safe to say 'Y' here.
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-- 
1.9.1

