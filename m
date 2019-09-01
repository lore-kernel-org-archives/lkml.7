Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862C2C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDCE22CF7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567342118;
	bh=FTc+a17DsfhWBHvgS/X0zbGGAy3rch07vM/ZsVfYl1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kuCCyOPkqeGMYjf8WINUlV6V3u8xwE8guDyMAftD+tb6b9tV9U8HoRuz9Gj7ZWjKg
	 StxeA2AU0kMDENJaZNjbTlle65Fms7M4EQoYJJDLi6KsbHThtTYwuuV0q1Puc4rB23
	 FzjxdOPtF69Axo6uxLYEV9olNV+IXF4SDNTXb8HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfIAMsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfIAMsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EC94308424C;
        Sun,  1 Sep 2019 12:48:36 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E75EE6012E;
        Sun,  1 Sep 2019 12:48:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 4/4] libperf: Add missing event.h into install rule
Date:   Sun,  1 Sep 2019 14:48:22 +0200
Message-Id: <20190901124822.10132-5-jolsa@kernel.org>
In-Reply-To: <20190901124822.10132-1-jolsa@kernel.org>
References: <20190901124822.10132-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 01 Sep 2019 12:48:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it's properly installed.

Link: http://lkml.kernel.org/n/tip-7e989xk9ykmd60db9lym5uc6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index a67efb8d9d39..e325c0503dc6 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -146,6 +146,7 @@ install_headers:
 		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644);
+		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644);
 
 install_pkgconfig: $(LIBPERF_PC)
 	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
-- 
2.21.0

