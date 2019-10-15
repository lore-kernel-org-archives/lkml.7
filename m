Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692C2ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479C42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfJOFcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42269 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfJOFc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR4-0000Bt-39; Tue, 15 Oct 2019 07:31:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1E7631C04D7;
        Tue, 15 Oct 2019 07:31:42 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:42 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] MAINTAINERS: Add entry for perf tool arm64 pmu-events files
Cc:     John Garry <john.garry@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1570611273-108281-1-git-send-email-john.garry@huawei.com>
References: <1570611273-108281-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <157111750205.12254.13465926199469128241.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     26d5310ee28ad9395bd676f750d2ee3ddff3dcfd
Gitweb:        https://git.kernel.org/tip/26d5310ee28ad9395bd676f750d2ee3ddff3dcfd
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Wed, 09 Oct 2019 16:54:33 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 09:35:12 -03:00

MAINTAINERS: Add entry for perf tool arm64 pmu-events files

Will and I have an interest in reviewing the pmu-events changes related
to arm64, so add a specific entry for this.

Signed-off-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linuxarm@huawei.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will@kernel.org>
Link: http://lore.kernel.org/lkml/1570611273-108281-1-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef..b50ddc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12771,6 +12771,13 @@ F:	arch/*/events/*
 F:	arch/*/events/*/*
 F:	tools/perf/
 
+PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
+R:	John Garry <john.garry@huawei.com>
+R:	Will Deacon <will@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	tools/perf/pmu-events/arch/arm64/
+
 PERSONALITY HANDLING
 M:	Christoph Hellwig <hch@infradead.org>
 L:	linux-abi-devel@lists.sourceforge.net
