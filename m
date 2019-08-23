Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE354C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A7521897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394499AbfHWMVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:21:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394465AbfHWMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:21:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18ZX-0001gT-0q; Fri, 23 Aug 2019 14:21:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E16881C04F3;
        Fri, 23 Aug 2019 14:21:37 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:21:37 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools headers: Add missing perf_event.h include
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tip-bolqkmqajexhccjb0ib0an8w@git.kernel.org>
References: <tip-bolqkmqajexhccjb0ib0an8w@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156656289778.31529.12212870654229983416.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     db9a5fd02a06113848fd3eabe302f56059d27366
Gitweb:        https://git.kernel.org/tip/db9a5fd02a06113848fd3eabe302f56059d27366
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 22 Aug 2019 13:11:37 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 11:12:36 -03:00

tools headers: Add missing perf_event.h include

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
index 9a083ae..6c02617 100644
--- a/tools/include/linux/ring_buffer.h
+++ b/tools/include/linux/ring_buffer.h
@@ -2,6 +2,7 @@
 #define _TOOLS_LINUX_RING_BUFFER_H_
 
 #include <asm/barrier.h>
+#include <linux/perf_event.h>
 
 /*
  * Contract with kernel for walking the perf ring buffer from
