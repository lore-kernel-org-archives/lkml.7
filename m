Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64DBC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A342173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="219bwk71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404721AbfHHUUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:20:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404467AbfHHUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:20:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KK7j53321408
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:20:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KK7j53321408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295608;
        bh=lX1hCaVCNaoNqHRRttyKwMgi6ZhuouRYalN700/XUvs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=219bwk71GfkGDzN4kMGaCzm9U8T5RIiYYNJ0SeOeTdHWBup5EzPswJu1J8V2tf6yT
         IBeN01ErrPyi3R1hYw/wd/ouvPpXhOoe/T8CifO4IYl3GUaUIUQpzjYU23qvQBJp8l
         eoJDd9IT4qaymhAzj9p98NLkf40s1z/Ei9ak63oFusBiDr3SpboGK07TN2mH6k3Q2J
         NZQ8G/JzbBnmgiA91uZMa6O7poK9zeB8dC/cebI50Arf+2uIAvEt62X4ZYdAWkgUJ7
         ymTpr+sTs12dEin/1W96YxtJhrYXypVrx0Z+HoVwudq1vj90/ASFvmDvV/s5tv1KMT
         zt8nmZoJ2bpGQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KK7DB3321405;
        Thu, 8 Aug 2019 13:20:07 -0700
Date:   Thu, 8 Aug 2019 13:20:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masanari Iida <tipbot@zytor.com>
Message-ID: <tip-89b66500f739e0033ef59011e3df694f2053679d@git.kernel.org>
Cc:     namhyung@kernel.org, peterz@infradead.org, standby24x7@gmail.com,
        hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        mojha@codeaurora.org, mingo@kernel.org
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          mojha@codeaurora.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          standby24x7@gmail.com, peterz@infradead.org, namhyung@kernel.org
In-Reply-To: <20190801032812.25018-1-standby24x7@gmail.com>
References: <20190801032812.25018-1-standby24x7@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix a typo in a variable name in the
 Documentation Makefile
Git-Commit-ID: 89b66500f739e0033ef59011e3df694f2053679d
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

Commit-ID:  89b66500f739e0033ef59011e3df694f2053679d
Gitweb:     https://git.kernel.org/tip/89b66500f739e0033ef59011e3df694f2053679d
Author:     Masanari Iida <standby24x7@gmail.com>
AuthorDate: Thu, 1 Aug 2019 12:28:12 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:41:10 -0300

perf tools: Fix a typo in a variable name in the Documentation Makefile

This patch fix a spelling typo in a variable name in the Documentation Makefile.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190801032812.25018-1-standby24x7@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 6d148a40551c..adc5a7e44b98 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -242,7 +242,7 @@ $(OUTPUT)doc.dep : $(wildcard *.txt) build-docdep.perl
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
--include $(OUPTUT)doc.dep
+-include $(OUTPUT)doc.dep
 
 _cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-ancillarymanipulators.txt \
