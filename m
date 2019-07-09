Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA818C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DD420665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697179;
	bh=hG55PhgOHy3ikEgahhbxuo3nTT8T+RySmL74y+x7wmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZiD54fGuaPJ81GnnWsW3ryn+4iLjgcLzBnhPaz0wU7r7vfsQNxCJ2Pnnv/Zv6CrAs
	 qR9vx4e6MJ/p8yc16T91zr7rlZRWAfPNSVhPv06O4Njs5w2KywT4PcaWsj806smhCY
	 WH63vLdvu3RHgvPmEH6+tyMAfgiNcUQfslkF5LC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfGISc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGISc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:32:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118C5216C4;
        Tue,  9 Jul 2019 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697176;
        bh=hG55PhgOHy3ikEgahhbxuo3nTT8T+RySmL74y+x7wmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPt0ApImb9gtCJ68fKUgahoIZcnJqkQsJV3ivaDzaPB7Blwp8dKEcPDCP4976iudJ
         p8CxI0JywoKvgR+VhT/a/+fKzigA89pCBa4mhCNZsMSCYM73GnPhrq6yCzsqIZEX8a
         Hy4UDbb53IsWrLJrb8sRpFixEzER0VscG2Uibb0A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Luke Mujica <lukemujica@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/25] perf parse-events: Remove unused variable 'i'
Date:   Tue,  9 Jul 2019 15:31:18 -0300
Message-Id: <20190709183126.30257-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luke Mujica <lukemujica@google.com>

Remove the 'int i' because it is declared but not used in parse-events.y
or in the generated parse-events.c.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190703222509.109616-1-lukemujica@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 6ad8d4914969..172dbb73941f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -626,7 +626,6 @@ PE_TERM
 PE_NAME array '=' PE_NAME
 {
 	struct parse_events_term *term;
-	int i;
 
 	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
 					$1, $4, &@1, &@4));
-- 
2.21.0

