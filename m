Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D918CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D07A23406
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507675;
	bh=BcDX8dUjw6qAOCyvyiuWHEAhm94TJG9w3SIocu8kiAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e7GB0/7/65ArFLxYL4xFCxItTFEaYc5nkONvanNY8XxhKJ2ltadGfmzcOooxkPkF9
	 txxgjdPglLB01Bhxuwb1U95CT0/EoG+NNACYyLdm8hn+kdrlCbaKX8z+wQzl3uJFEi
	 1gQOIWAzDBROSxErgc2dfkK1BypNouZKDIj5EFTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392411AbfHVVBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733015AbfHVVBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:14 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2FC23402;
        Thu, 22 Aug 2019 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507674;
        bh=BcDX8dUjw6qAOCyvyiuWHEAhm94TJG9w3SIocu8kiAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+c4599JrrqlzKb+LScN2UehTMQ7xXmtHKhtz2bHZttaa3d9DRjoqg2khMLK/6d07
         BROUKySHJ7MZxRyi7w6b89fKqJS+E8VS+OLVeAqnpPczpiPhRq/vX//sb1nTf219Af
         fljvFUqxNKJS++VN0b0a2vzc5GC/e2vBD6/kixFE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/25] tools headers: Add missing perf_event.h include
Date:   Thu, 22 Aug 2019 18:00:36 -0300
Message-Id: <20190822210100.3461-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need perf_event.h include for 'struct perf_event_mmap_page'.

Link: http://lkml.kernel.org/n/tip-bolqkmqajexhccjb0ib0an8w@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190822111141.25823-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/ring_buffer.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/ring_buffer.h b/tools/include/linux/ring_buffer.h
index 9a083ae60473..6c02617377c2 100644
--- a/tools/include/linux/ring_buffer.h
+++ b/tools/include/linux/ring_buffer.h
@@ -2,6 +2,7 @@
 #define _TOOLS_LINUX_RING_BUFFER_H_
 
 #include <asm/barrier.h>
+#include <linux/perf_event.h>
 
 /*
  * Contract with kernel for walking the perf ring buffer from
-- 
2.21.0

