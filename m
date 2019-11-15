Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46973C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236DE20733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKOJRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:17:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:46998 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfKOJRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:17:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 01:17:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,307,1569308400"; 
   d="scan'208";a="236009207"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2019 01:17:31 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] trace/synthetic_events: increase SYNTH_FIELDS_MAX
Date:   Fri, 15 Nov 2019 11:17:30 +0200
Message-Id: <20191115091730.9192-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Increase the maximum allowed count of synthetic event fields from 16 to 32
in order to allow for larger-than-usual events.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7482a1466ebf..f49d1a36d3ae 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -23,7 +23,7 @@
 #include "trace_dynevent.h"
 
 #define SYNTH_SYSTEM		"synthetic"
-#define SYNTH_FIELDS_MAX	16
+#define SYNTH_FIELDS_MAX	32
 
 #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
 
-- 
2.20.1

