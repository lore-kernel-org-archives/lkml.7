Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3574C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852992070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfIVKwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 06:52:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55557 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfIVKwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 06:52:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBzTd-0000vD-Je; Sun, 22 Sep 2019 12:52:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 236161C07C3;
        Sun, 22 Sep 2019 12:52:25 +0200 (CEST)
Date:   Sun, 22 Sep 2019 10:52:25 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools arch x86 uapi: Synch asm/unistd.h with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156914954504.24167.15576551007465139001.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     761830a03c5c99fc0a7142e16cf0811cb68bd7af
Gitweb:        https://git.kernel.org/tip/761830a03c5c99fc0a7142e16cf0811cb68bd7af
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 20 Sep 2019 14:56:47 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 14:59:28 -03:00

tools arch x86 uapi: Synch asm/unistd.h with the kernel sources

To pick up the change in:

  45e29d119e99 ("x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long")

That doesn't trigger any changes in tooling and silences this perf build
warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/unistd.h' differs from latest version at 'arch/x86/include/uapi/asm/unistd.h'
  diff -u tools/arch/x86/include/uapi/asm/unistd.h arch/x86/include/uapi/asm/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd.h b/tools/arch/x86/include/uapi/asm/unistd.h
index 30d7d04..196fdd0 100644
--- a/tools/arch/x86/include/uapi/asm/unistd.h
+++ b/tools/arch/x86/include/uapi/asm/unistd.h
@@ -3,7 +3,7 @@
 #define _UAPI_ASM_X86_UNISTD_H
 
 /* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000
+#define __X32_SYSCALL_BIT	0x40000000UL
 
 #ifndef __KERNEL__
 # ifdef __i386__
