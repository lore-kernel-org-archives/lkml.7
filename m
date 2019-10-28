Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAE6CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFC320659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbfJ1LmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:42:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbfJ1LmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:42:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iP3PA-0001G3-6G; Mon, 28 Oct 2019 12:41:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 645B11C0081;
        Mon, 28 Oct 2019 12:41:47 +0100 (CET)
Date:   Mon, 28 Oct 2019 11:41:47 -0000
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/headers: Fix spelling s/EACCESS/EACCES/,
 s/privilidge/privilege/
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Kosina <trivial@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191024122904.12463-1-geert+renesas@glider.be>
References: <20191024122904.12463-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <157226290708.29376.6650080342188215853.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     652521d460cbfa24ef27717b4b28acfac4281be6
Gitweb:        https://git.kernel.org/tip/652521d460cbfa24ef27717b4b28acfac4281be6
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Thu, 24 Oct 2019 14:29:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Oct 2019 11:02:01 +01:00

perf/headers: Fix spelling s/EACCESS/EACCES/, s/privilidge/privilege/

As per POSIX, the correct spelling of the error code is EACCES:

  include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Kosina <trivial@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20191024122904.12463-1-geert+renesas@glider.be
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c1..68ccc5b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -292,7 +292,7 @@ struct pmu {
 	 *  -EBUSY	-- @event is for this PMU but PMU temporarily unavailable
 	 *  -EINVAL	-- @event is for this PMU but @event is not valid
 	 *  -EOPNOTSUPP -- @event is for this PMU, @event is valid, but not supported
-	 *  -EACCESS	-- @event is for this PMU, @event is valid, but no privilidges
+	 *  -EACCES	-- @event is for this PMU, @event is valid, but no privileges
 	 *
 	 *  0		-- @event is for this PMU and valid
 	 *
