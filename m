Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97982C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B38C218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfB1Hrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:47:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40335 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1Hrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:47:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7katD2950189
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:46:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7kaK92950186;
        Wed, 27 Feb 2019 23:46:36 -0800
Date:   Wed, 27 Feb 2019 23:46:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b20fe10642f90d17c07b5e621bf4c00093c5654b@git.kernel.org>
Cc:     acme@redhat.com, songliubraving@fb.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
        namhyung@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        ak@linux.intel.com
Reply-To: jolsa@kernel.org, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          ak@linux.intel.com, acme@redhat.com, songliubraving@fb.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190220122800.864-5-jolsa@kernel.org>
References: <20190220122800.864-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf-event: Add missing new line into pr_debug
 call
Git-Commit-ID: b20fe10642f90d17c07b5e621bf4c00093c5654b
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

Commit-ID:  b20fe10642f90d17c07b5e621bf4c00093c5654b
Gitweb:     https://git.kernel.org/tip/b20fe10642f90d17c07b5e621bf4c00093c5654b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 20 Feb 2019 13:27:58 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 20 Feb 2019 16:23:07 -0300

perf bpf-event: Add missing new line into pr_debug call

Add a missing new line into pr_debug call in perf_event__synthesize_bpf_events(),
so that the error message does not screw the verbose output.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lkml.kernel.org/r/20190220122800.864-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 62dda96b0096..028c8ec1f62a 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -233,7 +233,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 				err = 0;
 				break;
 			}
-			pr_debug("%s: can't get next program: %s%s",
+			pr_debug("%s: can't get next program: %s%s\n",
 				 __func__, strerror(errno),
 				 errno == EINVAL ? " -- kernel too old?" : "");
 			/* don't report error on old kernel or EPERM  */
