Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B61C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDA62084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OQATRfzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfFQTgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:36:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52871 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFQTgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:36:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJZTab3565605
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:35:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJZTab3565605
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800130;
        bh=MBXOwA4rpmjuC7sDNtWsv8DLbEfZSsKX8z7jw9/TwM0=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=OQATRfzOJ4RZ+8CpgujyJ+DYuGdvq3DqOFAHC//L6kgmitjzN8OCkhAfYQgltoHBw
         +zx7HjiP5/iGEMoqXGJp/+ziwXKLtub+3Xh+E4wZqwwvGfEbEQMS8V86Jp2mL9s+0o
         CyUGhaFVSh094yt6kCKVGaj5roe7s2qVUHCoFuwrmGY93nC0FXM6RChWqhoneX6WqJ
         Jyr1BDM+VYvF0kWSbpRGq4IFXdkSnyfMUhQpGC6UWJEbOg8kXSD6poYKVtyBLuCvuW
         rW6XmhJGnR/2Bq22Xv7mMTcwApmN2R9aJe+iG5kps0l/Jk4sLMApzn/S/xF3NS5feK
         PdeziAH60Xsmw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJZTUh3565601;
        Mon, 17 Jun 2019 12:35:29 -0700
Date:   Mon, 17 Jun 2019 12:35:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-nubi6mxp2n8ofvlx7ph6k3h6@git.kernel.org>
Cc:     peterz@infradead.org, ak@linux.intel.com, mingo@kernel.org,
        hpa@zytor.com, adrian.hunter@intel.com, tglx@linutronix.de,
        kan.liang@linux.intel.com, acme@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
          ak@linux.intel.com, namhyung@kernel.org, acme@redhat.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, tglx@linutronix.de,
          kan.liang@linux.intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Fix perf.data documentation for
 HEADER_CPU_TOPOLOGY
Git-Commit-ID: 36edfb940195b62c79bc8b148720c8275659a8c7
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

Commit-ID:  36edfb940195b62c79bc8b148720c8275659a8c7
Gitweb:     https://git.kernel.org/tip/36edfb940195b62c79bc8b148720c8275659a8c7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 6 Jun 2019 17:03:18 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:11 -0300

perf data: Fix perf.data documentation for HEADER_CPU_TOPOLOGY

The 'die' info isn't in the same array as core and socket ids, and we
missed the 'dies' string list, that comes right after the 'core' +
'socket' id variable length array, followed by the VLA for the dies.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: c9cb12c5ba08 ("perf header: Add die information in CPU topology")
Link: https://lkml.kernel.org/n/tip-nubi6mxp2n8ofvlx7ph6k3h6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 29 ++++++++++++++++------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index de78183f6881..5f54feb19977 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -151,20 +151,35 @@ struct {
 
 	HEADER_CPU_TOPOLOGY = 13,
 
-String lists defining the core and CPU threads topology.
-The string lists are followed by a variable length array
-which contains core_id, die_id (for x86) and socket_id of each cpu.
-The number of entries can be determined by the size of the
-section minus the sizes of both string lists.
-
 struct {
+	/*
+	 * First revision of HEADER_CPU_TOPOLOGY
+	 *
+	 * See 'struct perf_header_string_list' definition earlier
+	 * in this file.
+	 */
+
        struct perf_header_string_list cores; /* Variable length */
        struct perf_header_string_list threads; /* Variable length */
+
+       /*
+        * Second revision of HEADER_CPU_TOPOLOGY, older tools
+        * will not consider what comes next
+        */
+
        struct {
 	      uint32_t core_id;
-	      uint32_t die_id;
 	      uint32_t socket_id;
        } cpus[nr]; /* Variable length records */
+       /* 'nr' comes from previously processed HEADER_NRCPUS's nr_cpu_avail */
+
+        /*
+	 * Third revision of HEADER_CPU_TOPOLOGY, older tools
+	 * will not consider what comes next
+	 */
+
+	struct perf_header_string_list dies; /* Variable length */
+	uint32_t die_id[nr_cpus_avail]; /* from previously processed HEADER_NR_CPUS, VLA */
 };
 
 Example:
