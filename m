Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6621ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4361D206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfJUG0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:26:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33199 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUG0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:26:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMR9O-00025o-7H; Mon, 21 Oct 2019 08:26:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B9F951C0092;
        Mon, 21 Oct 2019 08:26:41 +0200 (CEST)
Date:   Mon, 21 Oct 2019 06:26:41 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers kvm: Sync kvm headers with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-pqzkt1hmfpqph3ts8i6zzmim@git.kernel.org>
References: <tip-pqzkt1hmfpqph3ts8i6zzmim@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157163920149.29376.13457875113967123033.tip-bot2@tip-bot2>
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

Commit-ID:     7cb3a2445705e45af9b58dd241d26598a35b1fdd
Gitweb:        https://git.kernel.org/tip/7cb3a2445705e45af9b58dd241d26598a35b1fdd
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 15 Oct 2019 12:30:08 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 12:30:08 -03:00

tools headers kvm: Sync kvm headers with the kernel sources

To pick the changes in:

    0cb8410b90e7 ("kvm: svm: Intercept RDPRU")

That trigger a rebuild in too in tooling:

    CC       /tmp/build/perf/arch/x86/util/kvm-stat.o

But this time around no changes in tooling results, as SVM_EXIT_RDPRU
wasn't added to SVM_EXIT_REASONS, that is used in kvm-stat.c.

And addresses this perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/svm.h' differs from latest version at 'arch/x86/include/uapi/asm/svm.h'
  diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/n/tip-pqzkt1hmfpqph3ts8i6zzmim@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/svm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/svm.h b/tools/arch/x86/include/uapi/asm/svm.h
index a9731f8..2e8a30f 100644
--- a/tools/arch/x86/include/uapi/asm/svm.h
+++ b/tools/arch/x86/include/uapi/asm/svm.h
@@ -75,6 +75,7 @@
 #define SVM_EXIT_MWAIT         0x08b
 #define SVM_EXIT_MWAIT_COND    0x08c
 #define SVM_EXIT_XSETBV        0x08d
+#define SVM_EXIT_RDPRU         0x08e
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
