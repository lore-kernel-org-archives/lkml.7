Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B50C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F112C21744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfIBIR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:17:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56361 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730344AbfIBIQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW7-0008FJ-7u; Mon, 02 Sep 2019 10:16:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 664861C0793;
        Mon,  2 Sep 2019 10:16:43 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:43 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf intel-pt: Remove inat.c from build dependency list
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <53776d6d29bc9eceb571d52df8fa32250c58a0f3.1567118001.git.jpoimboe@redhat.com>
References: <53776d6d29bc9eceb571d52df8fa32250c58a0f3.1567118001.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <156741220324.17395.10042321867096660211.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f1da0a6c136542b9571b30af27bc1e84254f7a47
Gitweb:        https://git.kernel.org/tip/f1da0a6c136542b9571b30af27bc1e84254f7a47
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 17:41:20 -05:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:27:52 -03:00

perf intel-pt: Remove inat.c from build dependency list

intel-pt-insn-decoder.c includes inat.c directly, so it already has an
implicit dependency on inat.c.  The Build file dependency is redundant.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/53776d6d29bc9eceb571d52df8fa32250c58a0f3.1567118001.git.jpoimboe@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 23bf788..acb18a3 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -9,7 +9,7 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
 
 # Busybox's diff doesn't have -I, avoid warning in the case
 
-$(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/intel-pt-insn-decoder.c util/intel-pt-decoder/inat.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
+$(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/intel-pt-insn-decoder.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
 	@(diff -I 2>&1 | grep -q 'option requires an argument' && \
 	test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
 	((diff -B -I'^#include' util/intel-pt-decoder/insn.c ../../arch/x86/lib/insn.c >/dev/null) || \
