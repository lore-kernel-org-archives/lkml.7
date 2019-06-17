Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5398DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FE12084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HkJptBPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfFQS43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:56:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40115 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFQS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:56:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HIthWx3553302
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 11:55:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HIthWx3553302
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560797744;
        bh=oRMN8qn2vkQyPuVg2GvCCarvw+Et0n/MGAWoaVpgTg4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=HkJptBPba16fc2cCM7LC4cbJEaLCVROiKSRBvvBbzqm+c3DJ92AbZ4df4Jl7OykB+
         K9WnlLgvIi2Isy5d80dWgya2YRedLN6aG/52BEQnOmehYJATLg0dV8ilSpa4jouyqa
         5R6y0/Fe/snGquHfhFRqSPRj44NpFv3nWH1UDEX9UfIvNjkHqvYTJr4e4t7i+t2BqX
         jdLpcaZInkHAkeJXuo16hjhVXcgNZGCn7LgLg/gHMyVnKw3lKjJ2l7bQyX009zQYKh
         O4r36hakyk3ysvAuxFvHlR97+QKQVk4/ir88AH0ytNpyyt7EZhVqJzkYgTqEljjkwT
         DFrhbjHyKFlSw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HIth5Y3553299;
        Mon, 17 Jun 2019 11:55:43 -0700
Date:   Mon, 17 Jun 2019 11:55:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-h5lcm1nbe9ztxwm61gmadd56@git.kernel.org>
Cc:     ak@linux.intel.com, tglx@linutronix.de, chongjiang@chromium.org,
        hpa@zytor.com, adrian.hunter@intel.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, sque@chromium.org,
        acme@redhat.com, mingo@kernel.org
Reply-To: mingo@kernel.org, acme@redhat.com, sque@chromium.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          hpa@zytor.com, chongjiang@chromium.org, ak@linux.intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Document memory topology header:
 HEADER_MEM_TOPOLOGY
Git-Commit-ID: 835fbf126ce0a359626bc59b8da4e7601f01fc87
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

Commit-ID:  835fbf126ce0a359626bc59b8da4e7601f01fc87
Gitweb:     https://git.kernel.org/tip/835fbf126ce0a359626bc59b8da4e7601f01fc87
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 29 May 2019 15:35:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:53 -0300

perf data: Document memory topology header: HEADER_MEM_TOPOLOGY

We forgot to update the perf.data file format document for the
HEADER_MEM_TOPOLOGY header, do it now from comments in the patch
introducing it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Simon Que <sque@chromium.org>
Fixes: e2091cedd51b ("perf tools: Add MEM_TOPOLOGY feature to perf data file")
Link: https://lkml.kernel.org/n/tip-h5lcm1nbe9ztxwm61gmadd56@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 022bb8b1c84a..99733751695b 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -272,6 +272,30 @@ struct {
 
 Two uint64_t for the time of first sample and the time of last sample.
 
+	HEADER_SAMPLE_TOPOLOGY = 22,
+
+Physical memory map and its node assignments.
+
+The format of data in MEM_TOPOLOGY is as follows:
+
+   0 - version          | for future changes
+   8 - block_size_bytes | /sys/devices/system/memory/block_size_bytes
+  16 - count            | number of nodes
+
+For each node we store map of physical indexes:
+
+  32 - node id          | node index
+  40 - size             | size of bitmap
+  48 - bitmap           | bitmap of memory indexes that belongs to node
+                        | /sys/devices/system/node/node<NODE>/memory<INDEX>
+
+The MEM_TOPOLOGY can be displayed with following command:
+
+$ perf report --header-only -I
+...
+# memory nodes (nr 1, block size 0x8000000):
+#    0 [7G]: 0-23,32-69
+
         HEADER_BPF_PROG_INFO = 25,
 
 struct bpf_prog_info_linear, which contains detailed information about
