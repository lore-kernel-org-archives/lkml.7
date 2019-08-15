Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A25EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D128F208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uRvTfM3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfHOJfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:35:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbfHOJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:35:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9ZF2O2275041
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:35:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9ZF2O2275041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861716;
        bh=dm16HIFA/tXkgLfMM0ox8GYhHgm8U+WBAdBwW0jWldM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uRvTfM3CiuSckvF5rP+ZwyiI0iT0YtszK1q8XlSORTkROf+6pulYhXMxBF1GjOIN+
         6DKJ/sRtndOOq/GBfK9uBqSG6gUXeHM7c4Ily14Z6jWlzSl+pquISmsQhmv2VpNSpA
         qSAxze+FOfqZyEHJbGs7Q2SldKFaMpCwrNDoevwb27mVys38kbjDadxr/Wuw6+xMv7
         pkHc8F+93a2UOJOdIuSlOzl1JIgYcbQ622eVqV24XboXOav6vyE0r2HB+3O8TkQq0t
         MF49709HdCEHniHEuFnUwjplx4aEZ0wKp2el+WA4Lvge/9+5kAemZvYuhH78HFEqYb
         k4BImthz66IPw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9ZFBv2275035;
        Thu, 15 Aug 2019 02:35:15 -0700
Date:   Thu, 15 Aug 2019 02:35:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vince Weaver <tipbot@zytor.com>
Message-ID: <tip-3143906c2770778d89b730e0342b745d1b4a8303@git.kernel.org>
Cc:     ak@linux.intel.com, chongjiang@chromium.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, sque@chromium.org,
        hpa@zytor.com, vincent.weaver@maine.edu, adrian.hunter@intel.com,
        namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com
Reply-To: vincent.weaver@maine.edu, adrian.hunter@intel.com, hpa@zytor.com,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, namhyung@kernel.org, mingo@kernel.org,
          acme@redhat.com, chongjiang@chromium.org, ak@linux.intel.com,
          sque@chromium.org, jolsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1908011425240.14303@macbook-air>
References: <alpine.DEB.2.21.1908011425240.14303@macbook-air>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf.data documentation: Clarify
 HEADER_SAMPLE_TOPOLOGY format
Git-Commit-ID: 3143906c2770778d89b730e0342b745d1b4a8303
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

Commit-ID:  3143906c2770778d89b730e0342b745d1b4a8303
Gitweb:     https://git.kernel.org/tip/3143906c2770778d89b730e0342b745d1b4a8303
Author:     Vince Weaver <vincent.weaver@maine.edu>
AuthorDate: Thu, 1 Aug 2019 14:30:43 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf.data documentation: Clarify HEADER_SAMPLE_TOPOLOGY format

The perf.data file format documentation for HEADER_SAMPLE_TOPOLOGY
specifies the layout in a confusing manner that doesn't match the rest
of the document.  This patch attempts to describe things consistent with
the rest of the file.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1908011425240.14303@macbook-air
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index d030c87ed9f5..b0152e1095c5 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -298,16 +298,21 @@ Physical memory map and its node assignments.
 
 The format of data in MEM_TOPOLOGY is as follows:
 
-   0 - version          | for future changes
-   8 - block_size_bytes | /sys/devices/system/memory/block_size_bytes
-  16 - count            | number of nodes
-
-For each node we store map of physical indexes:
-
-  32 - node id          | node index
-  40 - size             | size of bitmap
-  48 - bitmap           | bitmap of memory indexes that belongs to node
-                        | /sys/devices/system/node/node<NODE>/memory<INDEX>
+	u64 version;            // Currently 1
+	u64 block_size_bytes;   // /sys/devices/system/memory/block_size_bytes
+	u64 count;              // number of nodes
+
+struct memory_node {
+        u64 node_id;            // node index
+        u64 size;               // size of bitmap
+        struct bitmap {
+		/* size of bitmap again */
+                u64 bitmapsize;
+		/* bitmap of memory indexes that belongs to node     */
+		/* /sys/devices/system/node/node<NODE>/memory<INDEX> */
+                u64 entries[(bitmapsize/64)+1];
+        }
+}[count];
 
 The MEM_TOPOLOGY can be displayed with following command:
 
