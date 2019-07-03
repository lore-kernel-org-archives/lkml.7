Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA150C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6A6218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B/OOBfW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfGCOXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:23:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44479 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfGCOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:23:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EM59s3324001
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:22:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EM59s3324001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163726;
        bh=0AQywQaIuUi5GdmaT61KcMoN2YXSuYaZQDU7catum5Y=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=B/OOBfW7WTo5v3ZHwOCjb4DNPtuSs4XXXm/Ipg4dLE/pI6QGvXwQnRRGHnbcSslaI
         S/9/7rQuV3zm1L1ixVuggixeVF0z+wEt+Oz2TSC6+H1doAH+EqW6TeN24rdHBhjUs+
         MkW19GBCu3dGFqs4kJWU6wXeBAuS+xHDYqrNRuSLmVQEWeWY+iQffZzmoc9wvVJ7dX
         n67hF5xk38S0xr7Jlf675AxhW5PMLhk+S2XmY0/MZI7P0lDGkUOQ2yEOQ/xc9VK4pq
         OXZJAVfRKqIWtL0Es1bx1E4RaVRn57TJFySSpTIsc/Urr/XrWdU537a227IYeYql2/
         pfZdmkphWsF3Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EM5Kd3323998;
        Wed, 3 Jul 2019 07:22:05 -0700
Date:   Wed, 3 Jul 2019 07:22:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lcywlfqbi37nhegmhl1ar6wg@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, jolsa@kernel.org, mingo@kernel.org,
        ak@linux.intel.com, namhyung@kernel.org, tglx@linutronix.de
Reply-To: namhyung@kernel.org, tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, jolsa@kernel.org, mingo@kernel.org,
          ak@linux.intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Use skip_spaces()
Git-Commit-ID: 526bbbdd442ce143b52cd6a8b4ee424f9930be0d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  526bbbdd442ce143b52cd6a8b4ee424f9930be0d
Gitweb:     https://git.kernel.org/tip/526bbbdd442ce143b52cd6a8b4ee424f9930be0d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 26 Jun 2019 11:24:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 26 Jun 2019 11:31:43 -0300

perf report: Use skip_spaces()

No change in behaviour intended.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lcywlfqbi37nhegmhl1ar6wg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 91a3762b4211..aef59f318a67 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -941,8 +941,7 @@ parse_time_quantum(const struct option *opt, const char *arg,
 		pr_err("time quantum cannot be 0");
 		return -1;
 	}
-	while (isspace(*end))
-		end++;
+	end = skip_spaces(end);
 	if (*end == 0)
 		return 0;
 	if (!strcmp(end, "s")) {
