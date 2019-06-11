Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A7DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9907721855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279571;
	bh=8BLznbtLGYo5pMqNA3GbvXQfhGN9I9dfdgaPNqzsS5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AvQBxRltLP1sDI5jUo/6SahYCFSeTtenajyKk2GyBDAPMlK+lEWwvJpjEI3c+8fmj
	 Q8/7KU9XcqWSmXnlvAeJLkksCWLjpy48CnspDTe/T4rF423Gn6LLFp9k7gfMw0bWCL
	 McyX6EQy4sarG1T+F04s7DDrKt+JOFKjAFXE7edc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392207AbfFKS7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392181AbfFKS73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE4A2183F;
        Tue, 11 Jun 2019 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279569;
        bh=8BLznbtLGYo5pMqNA3GbvXQfhGN9I9dfdgaPNqzsS5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAmP3a1vNTXuD8fZhWfYqpWSPinFi0BfruSlS2FdAzLSGQo/mTERRXiVSCtQ5Mgs+
         XbkXA+5vNkaGT3PcpQw7GQtTBqnVnbiMosMG0JWu0ds1Wqj3qqF8+ZMbxcwXIOpui7
         NYmXNpmTPbkXl8aDKrhMg7ZpLCgMolmjLRjiA07c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Chong Jiang <chongjiang@chromium.org>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 02/85] perf data: Document memory topology header: HEADER_MEM_TOPOLOGY
Date:   Tue, 11 Jun 2019 15:57:48 -0300
Message-Id: <20190611185911.11645-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 .../Documentation/perf.data-file-format.txt   | 24 +++++++++++++++++++
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
-- 
2.20.1

