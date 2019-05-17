Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB345C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA5A2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122047;
	bh=kXXGkRDHpzADXMA2DwVf64P7O5B5o5vq66a3jHBeubE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Je3btDwUHvbmwAKdlBYpWkR7nSsHYHP1Tib5vvLEeBoNBYhc/CZ68AGx82fIXHn3X
	 Y9AigbXkR2FgkprvuOtga0aZVH9LZC4crUJTSslBxSG8av+zjVi2iMX9TEuooDlBUJ
	 bMb3XGnRsuZLp+zYNDf9eIq+AfvQYhMwohOy5Llo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfEQTkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729983AbfEQTkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:43 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD6A221734;
        Fri, 17 May 2019 19:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122042;
        bh=kXXGkRDHpzADXMA2DwVf64P7O5B5o5vq66a3jHBeubE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/4MZjyukqoDJYwfHHm8QlOq9m17G6g4qPS3Rr3DNMP1CqZ06vO6Ds+N8hw1zvyPh
         JjMPKGG06CuxCNDyJWCQmCOsemuDrO78PmB04+yEJaFDajCRqfdOkRZOC8X2aYHePp
         tR30g3aH9cDTxVIHGx1WXoKiqDvwVDRuCZNt5Xl8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Zenghui Yu <yuzenghui@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        wanghaibin.wang@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 60/73] perf jevents: Remove unused variable
Date:   Fri, 17 May 2019 16:35:58 -0300
Message-Id: <20190517193611.4974-61-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zenghui Yu <yuzenghui@huawei.com>

Address gcc warning:

  pmu-events/jevents.c: In function ‘save_arch_std_events’:
  pmu-events/jevents.c:417:15: warning: unused variable ‘sb’ [-Wunused-variable]
    struct stat *sb = data;
                 ^~

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: wanghaibin.wang@huawei.com
Link: http://lkml.kernel.org/r/1557919169-23972-1-git-send-email-yuzenghui@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index daaea5003d4a..58f77fd0f59f 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -415,7 +415,6 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *metric_name, char *metric_group)
 {
 	struct event_struct *es;
-	struct stat *sb = data;
 
 	es = malloc(sizeof(*es));
 	if (!es)
-- 
2.20.1

