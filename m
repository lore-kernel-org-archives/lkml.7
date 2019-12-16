Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C1AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237DF2467E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576529302;
	bh=30BeyDbJp+PUY3TJbi0EEvOIRwxjMQruO5n6kCSaXDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y6nK5SgONg21Mw/qyz4gMg58ODCdbxv11/yRZRiL+QAA2T3ajVdkCTmFFxxnbMHV/
	 wjnmPuhEGuSv8vVTNJkAStZObec9LeJ7VYrAjwjxpbcTe7HjGTH05sywAEKSEL7gDp
	 mVafveKrrWAy4peznQT1d6CYYS3jX6y3+wEgNfaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLPUsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfLPUsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:48:19 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5360621D7D;
        Mon, 16 Dec 2019 20:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576529299;
        bh=30BeyDbJp+PUY3TJbi0EEvOIRwxjMQruO5n6kCSaXDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Es0rhX3tIYvAGJxuAyVJkcUMlIfsQ9bmtOdgiAaj/o0l6VosoRgFBcaybjM0U6Dj3
         Ru6jUcTHwye6C/y88gQYBmdko6+ZeDp6Y3MxRiMPbpt5b2MSmMx/r/EVO2Og9rduET
         x6hAR5y7vAcuq0NAvEa7gG1bM69xn8VRcd4pSmP4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ed Maste <emaste@freebsd.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Hu <nickhu@andestech.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 9/9] perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description
Date:   Mon, 16 Dec 2019 17:47:38 -0300
Message-Id: <20191216204738.12107-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

In 7fcfa9a2d9 an unintended prefix "Counter:18 Name:" was removed from
the description for L1D_RO_EXCL_WRITES, but the extra name remained in
the description.  Remove it too.

Fixes: 7fcfa9a2d9a7 ("perf list: Fix s390 counter long description for L1D_RO_EXCL_WRITES")
Signed-off-by: Ed Maste <emaste@freebsd.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Link: http://lore.kernel.org/lkml/20191212145346.5026-1-emaste@freefall.freebsd.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z14/extended.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index 68618152ea2c..89e070727e1b 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -4,7 +4,7 @@
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
 		"Unit": "CPU-M-CF",
-- 
2.21.0

