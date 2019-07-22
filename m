Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3134C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E17B21985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817243;
	bh=zO2YznnBiAt5YWzqBE6v2EXnEulNY9aTwrWFby96fvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SpP47y9m1mx22s4mqTR/5pyHxh7wD2TmdMaw2hJO8Mvo7vOd7ca3kVWU9MgYm/pr4
	 DIQOuvIos4XPUc6R8y/mLOxrXEdYqZzj/xheeDBAk90X6KH/9Z8qk6/SExzE7TTesf
	 UR9UUeAAur/eMH5YLSPdDS+H5Mz3XF0CUnhWx8AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfGVRkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbfGVRkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:40 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF83C21955;
        Mon, 22 Jul 2019 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817240;
        bh=zO2YznnBiAt5YWzqBE6v2EXnEulNY9aTwrWFby96fvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxRx8XSDUu8ceKQSq5GC+UwoyuLLrPen+FS+dwJqsw6v+vUY7tVDQeAQgLZUoPJdl
         XGqdngU/EvR/ePs3O4Uoszyn2i7VXLdTmsI+CA6K8Bz+g95/CjQFboj55xGu81vRk1
         M3CHTSRKGbxXEXwF5g7+OVc0xD4SFc0n/O6E8uDg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/37] perf script: Fix --max-blocks man page description
Date:   Mon, 22 Jul 2019 14:38:18 -0300
Message-Id: <20190722173839.22898-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The --max-blocks description was using the old name brstackasm.  Use
brstackinsn instead.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190711181922.18765-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index d4e2e18a5881..042b9e5dcc32 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -384,7 +384,7 @@ include::itrace.txt[]
 	perf script --time 0%-10%,30%-40%
 
 --max-blocks::
-	Set the maximum number of program blocks to print with brstackasm for
+	Set the maximum number of program blocks to print with brstackinsn for
 	each sample.
 
 --reltime::
-- 
2.21.0

