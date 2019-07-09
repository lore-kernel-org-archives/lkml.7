Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68750C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AF020656
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697184;
	bh=+bbI8CCw/BZYZ26lYZsA8qZMGed2nsZC/c+U/8yw4wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RnEBBCCZADh9REkBgC+dhru7LJXpC5f8qqYCwgnOR5qKAC/4NICo6k41ea6UXyei9
	 HqYwxul/+m4JEszqwUdPRDtnA+hS10eP6MKzpGszDsGi2kGXSeo18xvHueNVeChdCr
	 la4gQ3hPjca3qJMVOfGJt4ImGItAsaj5+5Vb57Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfGISdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGISdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:33:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B3F21537;
        Tue,  9 Jul 2019 18:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697180;
        bh=+bbI8CCw/BZYZ26lYZsA8qZMGed2nsZC/c+U/8yw4wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQFQ8K/uCqqYlWFgI5m3qA/qlrRdoKlcUoBa9ygb/k0+/gPnE1OQJTp53baRQHHUd
         h94N2fnSp0kmV/1csS3Ih+0CSOGkBgtYDtZa4Gpb0CLmViVOE5m2a9/A387X5Br+DV
         vyGOnZP3qyBd9xxk+Of4Xacapnj+gSyy+wSRb9qw=
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
Subject: [PATCH 18/25] perf parse-events: Remove unused variable: error
Date:   Tue,  9 Jul 2019 15:31:19 -0300
Message-Id: <20190709183126.30257-19-acme@kernel.org>
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

Remove the 'error' variable because it is declared but not used in
parse-events.y or in the generated parse-events.c.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190703222509.109616-2-lukemujica@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 172dbb73941f..f1c36ed1cf36 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -480,7 +480,6 @@ event_bpf_file:
 PE_BPF_OBJECT opt_event_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
 	struct list_head *list;
 
 	ALLOC_LIST(list);
-- 
2.21.0

