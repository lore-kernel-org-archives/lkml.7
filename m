Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D250EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF09521897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391387AbfHWCoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:44:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391269AbfHWCoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:44:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zYn-0001Mj-5z; Fri, 23 Aug 2019 04:44:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A2ECF1C07E4;
        Fri, 23 Aug 2019 04:44:16 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:44:16 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools headers: Grab copy of linux/const.h,
 needed by linux/bits.h
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <tip-c2qfcbl58hxyfb5u5xivp7is@git.kernel.org>
References: <tip-c2qfcbl58hxyfb5u5xivp7is@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156652825655.13152.2129104996239365756.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     aaa6ef8aa85f33c6dd593e139b7f7d901bbde0e2
Gitweb:        https://git.kernel.org/tip/aaa6ef8aa85f33c6dd593e139b7f7d901bbde0e2
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 19 Aug 2019 11:00:54 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:08:23 -03:00

tools headers: Grab copy of linux/const.h, needed by linux/bits.h

So that can update the copy of linux/bits.h that now uses macros defined
in const.h and that are not available in older systems.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c2qfcbl58hxyfb5u5xivp7is@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/const.h      |  9 +++++++++-
 tools/include/uapi/linux/const.h | 31 +++++++++++++++++++++++++++++++-
 tools/perf/check-headers.sh      |  2 ++-
 3 files changed, 42 insertions(+)
 create mode 100644 tools/include/linux/const.h
 create mode 100644 tools/include/uapi/linux/const.h

diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
new file mode 100644
index 0000000..7b55a55
--- /dev/null
+++ b/tools/include/linux/const.h
@@ -0,0 +1,9 @@
+#ifndef _LINUX_CONST_H
+#define _LINUX_CONST_H
+
+#include <uapi/linux/const.h>
+
+#define UL(x)		(_UL(x))
+#define ULL(x)		(_ULL(x))
+
+#endif /* _LINUX_CONST_H */
diff --git a/tools/include/uapi/linux/const.h b/tools/include/uapi/linux/const.h
new file mode 100644
index 0000000..5ed721a
--- /dev/null
+++ b/tools/include/uapi/linux/const.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* const.h: Macros for dealing with constants.  */
+
+#ifndef _UAPI_LINUX_CONST_H
+#define _UAPI_LINUX_CONST_H
+
+/* Some constant macros are used in both assembler and
+ * C code.  Therefore we cannot annotate them always with
+ * 'UL' and other type specifiers unilaterally.  We
+ * use the following macros to deal with this.
+ *
+ * Similarly, _AT() will cast an expression with a type in C, but
+ * leave it unchanged in asm.
+ */
+
+#ifdef __ASSEMBLY__
+#define _AC(X,Y)	X
+#define _AT(T,X)	X
+#else
+#define __AC(X,Y)	(X##Y)
+#define _AC(X,Y)	__AC(X,Y)
+#define _AT(T,X)	((T)(X))
+#endif
+
+#define _UL(x)		(_AC(x, UL))
+#define _ULL(x)		(_AC(x, ULL))
+
+#define _BITUL(x)	(_UL(1) << (x))
+#define _BITULL(x)	(_ULL(1) << (x))
+
+#endif /* _UAPI_LINUX_CONST_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index f211c01..5308b38 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 HEADERS='
+include/uapi/linux/const.h
 include/uapi/drm/drm.h
 include/uapi/drm/i915_drm.h
 include/uapi/linux/fadvise.h
@@ -19,6 +20,7 @@ include/uapi/linux/usbdevice_fs.h
 include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
 include/linux/bits.h
+include/linux/const.h
 include/linux/hash.h
 include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
