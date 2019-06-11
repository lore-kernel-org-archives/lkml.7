Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AB9C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31C9217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279764;
	bh=0sTyWYXn4Pa+7X/55tb8NqyfN58bpln0gSI0xoGG/YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p/rJ1tYH50EJ1UmjWSGEhdZtJnIZe9HXSrceiMhYKJagKnZrDCTMF8mSM8k80xtUE
	 1VJxYmJ5c+18M6TugMqUuhSqlRQT4yQ6Kg+UN7pZOuEg9ztlW/emsH0o7bfzpdNY6P
	 EGknMBxr6j4UllnR88fUOi739y7+9fMQH1kN8mSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392389AbfFKTCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389575AbfFKTCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1DA21850;
        Tue, 11 Jun 2019 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279760;
        bh=0sTyWYXn4Pa+7X/55tb8NqyfN58bpln0gSI0xoGG/YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3kkv7c/rcygY4/5x0moLRw4ywftF8NOptTWJjwnL/3y4jUJg8J1HtL5SBU2R4Jzh
         wyblfBzVxm8D0NRQ2CXrBb74c35E+pbC6zgZBXsi0BxLTxiToO04qJVlTLs2zdTBus
         iqaxQnkWhwmHocmmkxG0JgsvfVHulkfPub56qegI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 44/85] perf cs-etm: Fix indentation in function cs_etm__process_decoder_queue()
Date:   Tue, 11 Jun 2019 15:58:30 -0300
Message-Id: <20190611185911.11645-45-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Fixing wrong indentation of the while() loop - no change of
functionality.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 3fa0e83e2948 ("perf cs-etm: Modularize main packet processing loop")
Link: http://lkml.kernel.org/r/20190524173508.29044-9-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 108 +++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a74c53a45839..68fec6f019fe 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1578,64 +1578,64 @@ static int cs_etm__process_decoder_queue(struct cs_etm_queue *etmq)
 
 	packet_queue = cs_etm__etmq_get_packet_queue(etmq);
 
-		/* Process each packet in this chunk */
-		while (1) {
-			ret = cs_etm_decoder__get_packet(packet_queue,
-							 etmq->packet);
-			if (ret <= 0)
-				/*
-				 * Stop processing this chunk on
-				 * end of data or error
-				 */
-				break;
+	/* Process each packet in this chunk */
+	while (1) {
+		ret = cs_etm_decoder__get_packet(packet_queue,
+						 etmq->packet);
+		if (ret <= 0)
+			/*
+			 * Stop processing this chunk on
+			 * end of data or error
+			 */
+			break;
+
+		/*
+		 * Since packet addresses are swapped in packet
+		 * handling within below switch() statements,
+		 * thus setting sample flags must be called
+		 * prior to switch() statement to use address
+		 * information before packets swapping.
+		 */
+		ret = cs_etm__set_sample_flags(etmq);
+		if (ret < 0)
+			break;
 
+		switch (etmq->packet->sample_type) {
+		case CS_ETM_RANGE:
 			/*
-			 * Since packet addresses are swapped in packet
-			 * handling within below switch() statements,
-			 * thus setting sample flags must be called
-			 * prior to switch() statement to use address
-			 * information before packets swapping.
+			 * If the packet contains an instruction
+			 * range, generate instruction sequence
+			 * events.
 			 */
-			ret = cs_etm__set_sample_flags(etmq);
-			if (ret < 0)
-				break;
-
-			switch (etmq->packet->sample_type) {
-			case CS_ETM_RANGE:
-				/*
-				 * If the packet contains an instruction
-				 * range, generate instruction sequence
-				 * events.
-				 */
-				cs_etm__sample(etmq);
-				break;
-			case CS_ETM_EXCEPTION:
-			case CS_ETM_EXCEPTION_RET:
-				/*
-				 * If the exception packet is coming,
-				 * make sure the previous instruction
-				 * range packet to be handled properly.
-				 */
-				cs_etm__exception(etmq);
-				break;
-			case CS_ETM_DISCONTINUITY:
-				/*
-				 * Discontinuity in trace, flush
-				 * previous branch stack
-				 */
-				cs_etm__flush(etmq);
-				break;
-			case CS_ETM_EMPTY:
-				/*
-				 * Should not receive empty packet,
-				 * report error.
-				 */
-				pr_err("CS ETM Trace: empty packet\n");
-				return -EINVAL;
-			default:
-				break;
-			}
+			cs_etm__sample(etmq);
+			break;
+		case CS_ETM_EXCEPTION:
+		case CS_ETM_EXCEPTION_RET:
+			/*
+			 * If the exception packet is coming,
+			 * make sure the previous instruction
+			 * range packet to be handled properly.
+			 */
+			cs_etm__exception(etmq);
+			break;
+		case CS_ETM_DISCONTINUITY:
+			/*
+			 * Discontinuity in trace, flush
+			 * previous branch stack
+			 */
+			cs_etm__flush(etmq);
+			break;
+		case CS_ETM_EMPTY:
+			/*
+			 * Should not receive empty packet,
+			 * report error.
+			 */
+			pr_err("CS ETM Trace: empty packet\n");
+			return -EINVAL;
+		default:
+			break;
 		}
+	}
 
 	return ret;
 }
-- 
2.20.1

