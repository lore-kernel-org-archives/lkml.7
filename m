Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E11C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653AB2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfDPLkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:40:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPLkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:40:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBeJG83429226
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:40:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBeJHH3429223;
        Tue, 16 Apr 2019 04:40:19 -0700
Date:   Tue, 16 Apr 2019 04:40:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-cf50d79a8cfe5adae37fec026220b009559bbeed@git.kernel.org>
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        hpa@zytor.com, acme@redhat.com, vincent.weaver@maine.edu,
        torvalds@linux-foundation.org, eranian@google.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: kan.liang@linux.intel.com, eranian@google.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          vincent.weaver@maine.edu, torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          hpa@zytor.com, jolsa@redhat.com, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <20190402194509.2832-12-kan.liang@linux.intel.com>
References: <20190402194509.2832-12-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/msr: Add Icelake support
Git-Commit-ID: cf50d79a8cfe5adae37fec026220b009559bbeed
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

Commit-ID:  cf50d79a8cfe5adae37fec026220b009559bbeed
Gitweb:     https://git.kernel.org/tip/cf50d79a8cfe5adae37fec026220b009559bbeed
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 2 Apr 2019 12:45:08 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:26:19 +0200

perf/x86/msr: Add Icelake support

Icelake is the same as the existing Skylake parts.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: jolsa@kernel.org
Link: https://lkml.kernel.org/r/20190402194509.2832-12-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index a878e6286e4a..f3f4c2263501 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -89,6 +89,7 @@ static bool test_intel(int idx)
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
 	case INTEL_FAM6_KABYLAKE_DESKTOP:
+	case INTEL_FAM6_ICELAKE_MOBILE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
