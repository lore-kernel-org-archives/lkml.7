Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D62C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0B22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989793;
	bh=E0+57h97BmZxolfjoPC8cTjO0II+vix3eDUp2lk7X+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2FTY3ZQiFfLDDcmWBaGYEpjGEekIDhLTKrFQMRqOA7xwn+bU5mkli4iEBBXVuXbbq
	 nxs4fQvp/xQC0xfE4eVUtADXyYQo1lNalFwFwfQeXaz0p4yjEt38W9t89xDdeggJPB
	 Adn6qz/GnmEbLxER67tijwfXUj5fWCcb9bBfMETQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390559AbfITO3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388868AbfITO0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06520208C3;
        Fri, 20 Sep 2019 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989560;
        bh=E0+57h97BmZxolfjoPC8cTjO0II+vix3eDUp2lk7X+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=md0eEQuit7NEgSjMhJ/i4iq79P2f9zwNmew/orBr+7g4x+saohjQgBcadWp5KmJlO
         HPlkcEx9UoBNMo+jOshhSKfsw8jWNJGmpXWoeHibfSExZiaEEXBWLVXdsR/Tfy3g69
         Y/kV5EhCwbiW1veAzBvl5ffnoCEznShdt7nxCiHk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/31] libperf: Add missing event.h file to install rule
Date:   Fri, 20 Sep 2019 11:25:14 -0300
Message-Id: <20190920142542.12047-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So that this development header is properly installed and can be found
by tools linking with libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190901124822.10132-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

