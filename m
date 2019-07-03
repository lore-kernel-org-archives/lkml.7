Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B499C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6456221881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OSDFpWbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfGCOOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:14:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGCOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:14:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EE7uv3322356
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:14:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EE7uv3322356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163248;
        bh=rflzOIBYdVCFbiPWca9hbxn5xuBeXPVnxM+9qirSjyI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=OSDFpWbVOG8P75Oceo7I7UprRYnl0iehFS2TbXzi5sNdqS/apcEsRx8jdeA6DIHw6
         FC6PvVUltGYYXSW0X31ozUeqSjRMO1Iuw/8dHkNF8v12ll+k58OMqYyPRFWZ9VgLcC
         GG26P1L1JZknZ9Z97TQSTGuM4n1Cisbh4XH1s3jo0ZxjzXb9H7rR0GRRUM9ek6MqdB
         +6WO1cEyVEN6cWvtbh72VN17IU4M5kk9oVZOXmN9yNsPy3J+SWz1icthwFl3Kcz13g
         9274GsRbaJnPsTpuJsiCH9ErSFUZwypfqjO/DPaX9HWGoXfr1eL4z7TrF6dSCFelSS
         rp6LDcaAknMLw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EE7QL3322353;
        Wed, 3 Jul 2019 07:14:07 -0700
Date:   Wed, 3 Jul 2019 07:14:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wlzwken4psiat4zvfbvaoqiw@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
        tglx@linutronix.de, adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
          namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Remove old baggage that is
 util/include/linux/ctype.h
Git-Commit-ID: 9f3926e08c26607a0dd5b1bc8a8aa1d03f72fcdc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9f3926e08c26607a0dd5b1bc8a8aa1d03f72fcdc
Gitweb:     https://git.kernel.org/tip/9f3926e08c26607a0dd5b1bc8a8aa1d03f72fcdc
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 18:19:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 18:31:12 -0300

perf tools: Remove old baggage that is util/include/linux/ctype.h

It was just including a ../util.h that wasn't even there:

  $ cat tools/perf/util/include/linux/../util.h
  cat: tools/perf/util/include/linux/../util.h: No such file or directory
  $

This would make kallsyms.h get util.h somehow and then files including
it would get util.h defined stuff, a mess, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wlzwken4psiat4zvfbvaoqiw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.h           | 1 -
 tools/perf/util/include/linux/ctype.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index bd988f7b18d4..2b238f181d97 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -3,7 +3,6 @@
 #define __TOOLS_KALLSYMS_H_ 1
 
 #include <elf.h>
-#include <linux/ctype.h>
 #include <linux/types.h>
 
 #ifndef KSYM_NAME_LEN
diff --git a/tools/perf/util/include/linux/ctype.h b/tools/perf/util/include/linux/ctype.h
deleted file mode 100644
index a53d4ee1e0b7..000000000000
--- a/tools/perf/util/include/linux/ctype.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../util.h"
