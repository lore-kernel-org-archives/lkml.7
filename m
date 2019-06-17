Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991DEC31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEC520665
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yF68pHW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfFQS5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:57:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFQS5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:57:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HIv6Ii3553746
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 11:57:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HIv6Ii3553746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560797827;
        bh=GLNvcVn2YgCnOqi9+MPHucFyhebjlRKNIQSdt2k3cg4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=yF68pHW8QQJzb3TNG/IP2MbVa3TLH7idIUCJ0k+2FUt0yR3vHHYJeNfRAgjRsFyr8
         5ZwCJjO5P92tkYQuOvszCv3VEGNbbaTnPCK4WM+jU1nqf3PWAqk6sylAm4dWVxev73
         k28ZAuz79pBy9otV3I7X7RZeGdNfJ/iJ/Zxeb9jBTs1huStilH7YDx9vBtDZDNdsdt
         IYkVxDtu71oYUGTODHPj234xneeEvutwU+agc3QMqexBp7OAEG8zhh4wL+EvriXiP+
         +C3eqeUPB8vyt9Vh/OfINcuEFUh5R2nnaWYTTOukkfc92fbJzyy+pcovBJbmqkh2WL
         u4YPll707WoBA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HIv5Ld3553743;
        Mon, 17 Jun 2019 11:57:05 -0700
Date:   Mon, 17 Jun 2019 11:57:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jbrzb7ijb5al33gi8br6f9rr@git.kernel.org>
Cc:     peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, hpa@zytor.com, ak@linux.intel.com,
        acme@redhat.com, sque@chromium.org, tglx@linutronix.de,
        mingo@kernel.org, adrian.hunter@intel.com,
        alexey.budankov@linux.intel.com, chongjiang@chromium.org
Reply-To: adrian.hunter@intel.com, chongjiang@chromium.org,
          alexey.budankov@linux.intel.com, ak@linux.intel.com,
          hpa@zytor.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de, sque@chromium.org,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Document directory format header:
 HEADER_DIR_FORMAT
Git-Commit-ID: 0da6ae94e4102fa145149dd0878b266c932507aa
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

Commit-ID:  0da6ae94e4102fa145149dd0878b266c932507aa
Gitweb:     https://git.kernel.org/tip/0da6ae94e4102fa145149dd0878b266c932507aa
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 29 May 2019 15:50:50 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:53 -0300

perf data: Document directory format header: HEADER_DIR_FORMAT

We forgot to update the perf.data file format document for the
HEADER_DIR_FORMAT header, do it now from comments in the patch
introducing it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Fixes: 258031c017c3 ("perf header: Add DIR_FORMAT feature to describe directory data")
Link: https://lkml.kernel.org/n/tip-jbrzb7ijb5al33gi8br6f9rr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 600999f89c6d..6375e6fb8bac 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -302,6 +302,23 @@ One uint64_t for the clockid frequency, specified, for instance, via 'perf
 record -k' (see clock_gettime()), to enable timestamps derived metrics
 conversion into wall clock time on the reporting stage.
 
+	HEADER_DIR_FORMAT = 24,
+
+The data files layout is described by HEADER_DIR_FORMAT feature.  Currently it
+holds only version number (1):
+
+  uint64_t version;
+
+The current version holds only version value (1) means that data files:
+
+- Follow the 'data.*' name format.
+
+- Contain raw events data in standard perf format as read from kernel (and need
+  to be sorted)
+
+Future versions are expected to describe different data files layout according
+to special needs.
+
         HEADER_BPF_PROG_INFO = 25,
 
 struct bpf_prog_info_linear, which contains detailed information about
