Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7BCC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4527420719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfKWSNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:13:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfKWSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F14D2073F;
        Sat, 23 Nov 2019 18:12:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZth-000Ezn-LJ; Sat, 23 Nov 2019 13:12:41 -0500
Message-Id: <20191123181241.538423996@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:12:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [for-next][PATCH 06/10] tracing: Fix Kconfig indentation
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Link: http://lkml.kernel.org/r/20191120133807.12741-1-krzk@kernel.org

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index b872716bb2a0..f67620499faa 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -79,7 +79,7 @@ config FTRACE_NMI_ENTER
 
 config EVENT_TRACING
 	select CONTEXT_SWITCH_TRACER
-        select GLOB
+	select GLOB
 	bool
 
 config CONTEXT_SWITCH_TRACER
@@ -311,7 +311,7 @@ config TRACER_SNAPSHOT
 	      cat snapshot
 
 config TRACER_SNAPSHOT_PER_CPU_SWAP
-        bool "Allow snapshot to swap per CPU"
+	bool "Allow snapshot to swap per CPU"
 	depends on TRACER_SNAPSHOT
 	select RING_BUFFER_ALLOW_SWAP
 	help
@@ -683,7 +683,7 @@ config MMIOTRACE_TEST
 	  Say N, unless you absolutely know what you are doing.
 
 config TRACEPOINT_BENCHMARK
-        bool "Add tracepoint that benchmarks tracepoints"
+	bool "Add tracepoint that benchmarks tracepoints"
 	help
 	 This option creates the tracepoint "benchmark:benchmark_event".
 	 When the tracepoint is enabled, it kicks off a kernel thread that
@@ -732,7 +732,7 @@ config RING_BUFFER_STARTUP_TEST
        bool "Ring buffer startup self test"
        depends on RING_BUFFER
        help
-         Run a simple self test on the ring buffer on boot up. Late in the
+	 Run a simple self test on the ring buffer on boot up. Late in the
 	 kernel boot sequence, the test will start that kicks off
 	 a thread per cpu. Each thread will write various size events
 	 into the ring buffer. Another thread is created to send IPIs
-- 
2.24.0


