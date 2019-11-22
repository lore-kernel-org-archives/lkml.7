Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B64C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E1E2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434712;
	bh=U+tcY+SJWfndTrheNTw31STbw/4M9GsmZcxi5VJMtxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b/aD+LxyIb8lBtcywdAFp+A4+4XyyGgbF5bCFMg47WeiQzfYqvASBuEDrIWGoCsfX
	 1N39E4kS+QxrfNO3ijSqs0/uilhPZhCXbZrNtkYwn1HbtAbDVY2RL+eBJVE4WMdl0F
	 +XKHZ31ISexQQnnQITgfhRD8NnG+sUQdzrA43kXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfKVO6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:58:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfKVO63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:58:29 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA9B2073B;
        Fri, 22 Nov 2019 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434708;
        bh=U+tcY+SJWfndTrheNTw31STbw/4M9GsmZcxi5VJMtxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+hEzz5/ySmx80Zx0QHu2y/VB8a7lBstrAwY0I/Lw1xI0w9XVMH9S2Z6q7+yxFUfc
         a+yquaZ+N7wgYAWjeDJssnJcMJDHjCmDg+XyE0Ov5D2dWcOPD/ksdsNRuCsLVPiQwC
         /SWk/dme6tTg8FUmui82ao3bZnyHnq17wfOz5OEI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/26] perf probe: Fix spelling mistake "addrees" -> "address"
Date:   Fri, 22 Nov 2019 11:57:10 -0300
Message-Id: <20191122145711.3171-26-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_warning message. Fix it.

Signed-off-by: Colin King <colin.king@canonical.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: http://lore.kernel.org/lkml/20191121092623.374896-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 38d6cd22779f..c470c49a804f 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -812,7 +812,7 @@ static int verify_representive_line(struct probe_finder *pf, const char *fname,
 	if (strcmp(fname, __fname) || lineno == __lineno)
 		return 0;
 
-	pr_warning("This line is sharing the addrees with other lines.\n");
+	pr_warning("This line is sharing the address with other lines.\n");
 
 	if (pf->pev->point.function) {
 		/* Find best match function name and lines */
-- 
2.21.0

