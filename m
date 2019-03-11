Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB45C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CB82084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfCKNTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfCKNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:30 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MbAYo-1gWU3t0tJI-00basd for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 012/114] arch: um: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:24 +0100
Message-Id: <1552310346-7629-13-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:+TXDl585hP44vwVZsQho//+OAw0bgOYrxfCl2tkj/bhLtjnPN/I
 pqgT51YfoNuXWbYF32WZ67KUWGabAvM0GLo9HmaV6iq2ixxgdxUkclFjBctLX1DSfsJqR8+
 s8VZ+WQy2ObtC/Mv0wTZKbRO8pz5jXNdUyDThy7sV57VO6xwYBhNJiDjome2mqutr2/TfSJ
 BVmNnQIcyAzdlOtqvxWqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:adLf6bH5Kjg=:l4W0TLtTvyQOgvBQsqhDpf
 pbSu/bDbIqBR1zPs/mgIf1VtdLdKafn57VhmNq/6BEshmEFdiYKaA4YWQC3bldEmF7wBcJG57
 UhUjH8K2RoAIBvif9BHs0u6nLciO0Q632G3c8I+48y7g9MOKBbkz2AnkB1eDEcwdxUCj92bbh
 gnNQMIxrAn3oqDZpKKgD09Iss0u2ndO56ZozEN1Fzp5k+OYXwx1egNnsh0j46UlRw1MTz2ijQ
 F0YW7KrsipuX8Dm2jp2AAh9FPC0v3OoNKoXCzFFWa0CaWNc0PWXBmMB6gJDj/QxePlnycMWN+
 1a9DzD2nbJhu6hY2G0/cVRoHW+ag0qe4mOGjGMCztUfOIDG5FKKDugSQe0Fu4kWuw19hKOHxr
 RPMJt5BcdHsyw03y+9ZLHuIcNdtfpN7fH38c+vWrmT5dFUSQvJU/h7Aee6LUBNVz6Su2A1RXi
 xZDSSGrWkCkNVEVh46ESKDpdiT++26FOrSK7rcc1eDEhyPsfKYyViLdbUDV6jkLSYp+JOh5/4
 /ABJfln1gxMgXi+bEjJEULi7vZ3m4c6NXrVXVtQT7usud4aEadxNpWmD6wdTg2yW8mu7ksJc8
 zppwV/Ayl8rATGR2jce9wxkk5FOuDwhfvlJCpVDEPMEyo2LXJqwi5HF2YVLBi1+3EvNWnw9Zw
 hCFYvaybu+C2j87ZNE2bnWpyZQdsUr4L9GoO5iEv2v3TeT84P64nUeprcOu4xfbGkAXb2ZpJN
 DPIVuRNZawDQqz5yIMzO3nW1cC5ef54njvpxVA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

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

