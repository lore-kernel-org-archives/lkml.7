Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE528C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBF123402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507738;
	bh=nK+KraOlYJIZ8uhhQBcjTlCqlC7Io6TrQfS2Wcsr+HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G55CWI1yjGFwn7+rsKky9K88wyHq6LhZLy8mRkTTmHaoJJr96Kely6W9XxL4Wf5Jm
	 UxA4lgyM8hkxZBLEDSt5JhVdNnOxZ9umbZ+dfu3mIoNw7yzrGMcye8KeGPhlECrRj+
	 HlkaAV18foJTMvlRM3Z5SClhPUOb1kuBdZvDpf1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393470AbfHVVCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393445AbfHVVCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:13 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 609A023401;
        Thu, 22 Aug 2019 21:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507733;
        bh=nK+KraOlYJIZ8uhhQBcjTlCqlC7Io6TrQfS2Wcsr+HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaFPt9JrJADBjweXWP1Yk0595EmsBzpY5b1Ulgi39Zev2uAXTD6qTXpoAAp5pE7wP
         6CLWYSgv7hYhetQ60uF/tLrox7E9OZ2JbXnQSV128p6OPusBHvZ4FL6Zx3x8yTMKtx
         dyBFKB09spHtmcTi48MAjRummvUVZbg2KaM6tVLc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 15/25] perf scripting python: Add missing counts.h header
Date:   Thu, 22 Aug 2019 18:00:50 -0300
Message-Id: <20190822210100.3461-16-acme@kernel.org>
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
Link: https://lkml.kernel.org/n/tip-6bxk3ltwkw91qcld2ot86bgg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 32c17a727450..51771fc0d0df 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -32,6 +32,7 @@
 #include <linux/time64.h>
 
 #include "../../perf.h"
+#include "../counts.h"
 #include "../debug.h"
 #include "../callchain.h"
 #include "../evsel.h"
-- 
2.21.0

