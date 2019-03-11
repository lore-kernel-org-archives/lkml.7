Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F05C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B99020883
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfCKNYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mbj3Y-1gUqAM1WCk-00dEm5 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 096/114] arch: openrisc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:48 +0100
Message-Id: <1552310346-7629-97-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:h2jP0AEfB4WomEB45piXLeE/aAi3cpALijHhN7G2CilDOMC0Foz
 GXr1caXK8mV7cknYHdfKPG0iTJfS1HtQT57wx6PSCxXXW/qwkTAxOYT1I59Q7dpLeezyeit
 jh/a425L0doQi7y3LdK1IOp5m2QVTxVJVtjEdanAUf2y6jZfWCz2ikA7ZmHS1lGL8j5Dx00
 yVW2yg/s/c1U9hNkYjYNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S0OGOxPAXH0=:kIjZj5+SOUrcsJ+IjVguYk
 KHKB8DiOPy8NYsls+eEnqArqCdOOMek/llPxwUKFIbFei56/BAa6SBSSyPLF35mQAJN6tPB6+
 kHsEsxmckrv9ZSNrt/1T+JwGTnoH1mxZd2K1APRmyCCsxMFzTpFs0cK99sIV3hLay4Wo/zLAk
 3/nolYkVZUHXbdhumqiC18tKd3pLKg0Wa9KjP7hNfWPb7mwx4jYcBXZltvJoOtYJmVL/SXOln
 u6pi3+tLeLYnvaM5kB7AyTnoZgyPv2XFpuD1YCWypjdD5tFWmcW9Qt+7L+ApLlYWJTTBt9j8m
 67JHCcXtsCc3FdknWbUj85U+9XVuDfHyEIChm4jTYNpVjgB/ChWCMLwts2YExIUv6+45Lwyid
 W71LiwJO7bO8K7/znCr3YwAAqfs1hFoTHHFZLfLp07YaVHGMpqycEr1bVoY/ulgLM6jNIFskT
 hS7FbKFHZ0NrXQWQGpzdhCK+TrlqdZj0wfPGRnjyo/GYk5sKb8g/9cSSsGY2FQiOxwMaYKtD1
 aBXx/LBMuq3Vl1VpR4BfSFK81+7ebFU+DyC+2LNQDnHkvFo9gVEC+x2oMlYsqYrvEQ7HVkTLC
 XIhuVO6x9ZIu18sSgry0MVxuLAaZ8ip9JiAoFEE+AVZlrqjnzNZqYlVQ6pAh22tkJ1E1TMInp
 yKuNAdRbfQSU77/e7efiNny+iHbv3FwM1uVnTBelD6j0VxLqk/J4LVycIpfXnBCjyhQmKasMm
 Wdj9N6Z5upgz8BSeA8nGk+Tlhxn7ylPYZJfTgg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/openrisc/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index a5e361f..4722291 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -13,7 +13,7 @@ config OPENRISC
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
 	select GPIOLIB
-        select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_TRACEHOOK
 	select SPARSE_IRQ
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
@@ -56,12 +56,12 @@ config NO_IOPORT_MAP
 	def_bool y
 
 config TRACE_IRQFLAGS_SUPPORT
-        def_bool y
+	def_bool y
 
 # For now, use generic checksum functions
 #These can be reimplemented in assembly later if so inclined
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config STACKTRACE_SUPPORT
 	def_bool y
@@ -94,8 +94,8 @@ config DCACHE_WRITETHROUGH
 	  If unsure say N here
 
 config OPENRISC_BUILTIN_DTB
-        string "Builtin DTB"
-        default ""
+	string "Builtin DTB"
+	default ""
 
 menu "Class II Instructions"
 
@@ -166,13 +166,13 @@ config OPENRISC_HAVE_SHADOW_GPRS
 	  On a unicore system it's safe to say N here if you are unsure.
 
 config CMDLINE
-        string "Default kernel command string"
-        default ""
-        help
-          On some architectures there is currently no way for the boot loader
-          to pass arguments to the kernel. For these architectures, you should
-          supply some command-line options at build time by entering them
-          here.
+	string "Default kernel command string"
+	default ""
+	help
+	  On some architectures there is currently no way for the boot loader
+	  to pass arguments to the kernel. For these architectures, you should
+	  supply some command-line options at build time by entering them
+	  here.
 
 menu "Debugging options"
 
@@ -190,7 +190,7 @@ config OPENRISC_ESR_EXCEPTION_BUG_CHECK
 	default n
 	help
 	  This option enables some checks that might expose some problems
-          in kernel.
+	  in kernel.
 
 	  Say N if you are unsure.
 
-- 
1.9.1

