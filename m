Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53962C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC86207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfL2MxB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 07:53:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46210 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfL2MxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 07:53:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ilY3x-00063M-Ew; Sun, 29 Dec 2019 13:52:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 86CE71C01BB;
        Sun, 29 Dec 2019 13:52:52 +0100 (CET)
Date:   Sun, 29 Dec 2019 12:52:52 -0000
From:   tip-bot2 for Valdis =?utf-8?q?Kl=C4=93tnieks?= 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/vdso: Provide missing include file
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <36224.1575599767@turing-police>
References: <36224.1575599767@turing-police>
MIME-Version: 1.0
Message-ID: <157762397235.30329.4277055045462310201.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     bff47c2302cc249bcd550b17067f8dddbd4b6f77
Gitweb:        https://git.kernel.org/tip/bff47c2302cc249bcd550b17067f8dddbd4b6f77
Author:        Valdis Klētnieks <valdis.kletnieks@vt.edu>
AuthorDate:    Thu, 05 Dec 2019 21:36:07 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 29 Dec 2019 13:41:31 +01:00

x86/vdso: Provide missing include file

When building with C=1, sparse issues a warning:

  CHECK   arch/x86/entry/vdso/vdso32-setup.c
  arch/x86/entry/vdso/vdso32-setup.c:28:28: warning: symbol 'vdso32_enabled' was not declared. Should it be static?

Provide the missing header file.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/36224.1575599767@turing-police
---
 arch/x86/entry/vdso/vdso32-setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 240626e..43842fa 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/kernel.h>
 #include <linux/mm_types.h>
+#include <linux/elf.h>
 
 #include <asm/processor.h>
 #include <asm/vdso.h>
