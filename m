Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8078C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0762229F3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563912351;
	bh=zO2YznnBiAt5YWzqBE6v2EXnEulNY9aTwrWFby96fvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jS3ymL3Gh2P3mWUhWFvA2buPc8xmC9OJaoRS/kFq9rsBjAe0VcDrUJu51/VqfoH85
	 PeqiSzTX+3oP8b2HZHIb7Hs3eFgbVUreMoAIr2YsaD4k+9MKQvb0JSIFA4nBdWRcmr
	 aO0feyORg4bZU19xhsV5IBs1oGrooswK6W3CI5oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfGWUFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731788AbfGWUFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:05:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49502229EC;
        Tue, 23 Jul 2019 20:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563912348;
        bh=zO2YznnBiAt5YWzqBE6v2EXnEulNY9aTwrWFby96fvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+dHlSZl2LQ4MnqgmBCrXas44ZSyFBHKO6uEHBuSuelO8yhT6NHatbWfpyOFkK/tQ
         0KTvN4S84f3flLFLup61PEsP84GHx6YZOxFnccqbNXMYyDjkNaDngT220SHaMw6c0T
         j5JWWs6A/aqI6+rnFmr1VMuVCAAmJUwLauw/ZdWw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/10] perf script: Fix --max-blocks man page description
Date:   Tue, 23 Jul 2019 17:05:21 -0300
Message-Id: <20190723200530.14090-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
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

