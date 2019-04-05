Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26BFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793482186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfDELhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:37:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38701 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:37:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35Bb9Mu2734349
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:37:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35Bb8Pi2734346;
        Fri, 5 Apr 2019 04:37:08 -0700
Date:   Fri, 5 Apr 2019 04:37:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-qkrld0v7boc9uabjbd8csxux@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        hbathini@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, acme@redhat.com,
          hbathini@linux.vnet.ibm.com, adrian.hunter@intel.com,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add header defining used namespace
 struct to event.h
Git-Commit-ID: 514c54039da970f953164c1960d0284f87db969d
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

Commit-ID:  514c54039da970f953164c1960d0284f87db969d
Gitweb:     https://git.kernel.org/tip/514c54039da970f953164c1960d0284f87db969d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 27 Mar 2019 15:22:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 14:49:24 -0300

perf tools: Add header defining used namespace struct to event.h

When adding the 'struct namespaces_event' to event.h, referencing the
'struct perf_ns_link_info' type, we forgot to add the header where it is
defined, getting that definition only by sheer luck.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: f3b3614a284d ("perf tools: Add PERF_RECORD_NAMESPACES to include namespaces related info")
Link: https://lkml.kernel.org/n/tip-qkrld0v7boc9uabjbd8csxux@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 36ae7e92dab1..4e908ec1ef64 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <linux/kernel.h>
 #include <linux/bpf.h>
+#include <linux/perf_event.h>
 
 #include "../perf.h"
 #include "build-id.h"
