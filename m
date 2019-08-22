Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4003C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D4023402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507725;
	bh=1MwG7RIv1THNr+WQTKVe5dsKMYphuScsrFdHJxj/3Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dpdI2/66cntrtJuO7BpKNAFCoVe0WfEZ4IiKAQqgfyePsGmEbQ1PpJ9B2EZx2yEAA
	 +RVXoK+eSv/lC6IE1rcX+fvwmU7J3qskqypqB4QYg2rYHc0n6eTTAvhKcE0NX6EPiN
	 FC8JSFFhnXr4Ly0TVCBpLQiToEcIwUt3kLDnV3jY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393436AbfHVVCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393410AbfHVVCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:01 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648822341C;
        Thu, 22 Aug 2019 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507720;
        bh=1MwG7RIv1THNr+WQTKVe5dsKMYphuScsrFdHJxj/3Kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6uumdBS24V8kxPsSLUZMM9DGNjzRQ1lQCrfGwxbkRGjQqYs+LvJmWoyqVgWcfDuR
         RhLO1XgCJknMZBHtMEyE1WphX1+pbkECLq/hd/Vm5g5l7QSflyvjDTe7HuI/f5oBnm
         nQPispl9L6r2z5lfhJzqZmcdL9hv0xssDqOLWxD0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/25] perf script: Add missing counts.h
Date:   Thu, 22 Aug 2019 18:00:47 -0300
Message-Id: <20190822210100.3461-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is getting this via evsel.h, that don't strictly need counts.h, just
forward declarations for some structs, so add it here before we remove
it from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-q4shpvlxyjqz7val1hyrdak9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1764efd16cd4..e957b870869b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3,6 +3,7 @@
 
 #include "perf.h"
 #include "util/cache.h"
+#include "util/counts.h"
 #include "util/debug.h"
 #include <subcmd/exec-cmd.h>
 #include "util/header.h"
-- 
2.21.0

