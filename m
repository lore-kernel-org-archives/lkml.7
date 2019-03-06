Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB34C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB69206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfCFS2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:28:33 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:52281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCFS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:28:30 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MNtGq-1hPrIZ2rN2-00ODxZ; Wed, 06 Mar 2019 19:28:19 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org
Subject: [PATCH] arch: um: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:28:17 +0100
Message-Id: <1551896897-30963-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:XEpfO4E2bPEq9qA3RyK4AI4azOcm+vfYdGyX8tkrR89C9tK3O1Z
 m/PXPM7u3ITOD0rqjx1e90StjExsWH5D7EUY6e7cppzZRiaLFFiMnUiMj6LRH/ROCti6Hur
 qbMIguHKmlZE9DGRx8FQ+P95HzCofRkSyt06NDvO0uRalYhg87yh4gd9ObuuYKY1pTcqhOs
 j1t9XuW/I9f2I1kC0LSeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DDmjs/wdduc=:jm5wAXr6Buyq+n8v/7QQYQ
 GFewK/TpL0dgypMNNEZZPcCsGC0vXLQH1IckQHyruiTFeT8gPxOuq957bB0gkYhlS2neSfcUR
 4j+0RwuK0fnbqisV90KAc/pl4kvjpfKJSw5CbFFApeDYMYMDsXTIT2SvQLCIwvLFJoUJ/MxKp
 PaiJ54cLsNvoURYszeHHD4DFwyG00NIj9Td9w5UtptDdRJqKa+Kp5DjJk8XTggj/JbwN53kks
 iLyjWUIwemm/Qn7AyCE5EgWI6+wAaW0J8ClRSBp4iLKVVPwyQ88syJpEJRFGeKJS8gEBtdN9/
 sQV+Aj7O0LkATt0WmHgwl6ltpwSyAZJkXg4IeBqvF4FLqVuHMxdOTlP6yQWfrL5X0C4VLt7wq
 TnD84krUMVjHcMbunGCrHDOisZuqjKmWb9wD0cFPbpIN6sPmz8TsDtyDienmCLB6hreTf2s1n
 zd/88L8YFgxsCJecsF66tNTMmOwSTrqU1Yk07/eIMMGBKvV35VJ5kaA+tRfRJn2ysysVGnecu
 iPbmz6Thnd5Z8AkQvVhCWEJ1YzQadDU0OzbzkNxqiB0PA3M1SMirwt8reQDvgUSjGXNxTHN6m
 xR4zwDxJN88vDd8GZpr070dFMeZZmtTXTHWOq3SHznCGfmOB7h3Tlj8Dcsh8WCeMwX4h+rk3n
 WcUuF1W+EjJq/dTFBDQSMhdZWebA2RHnc8N+LVUQ/5M8cKguxmyAbYYLRyfvYv9rXd3xTDovx
 9dFBAvkljimWpQw4fsdgtEaoxUZLOqfRajURyw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

