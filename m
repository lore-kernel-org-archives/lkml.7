Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4D8C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E522084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="q2ztoGVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfFQS4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:56:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFQS4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:56:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HIuObi3553408
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 11:56:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HIuObi3553408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560797785;
        bh=mEyJNqo4FFbaepedw9v87K8lEFqEvaLoJhBUa2TTJ2g=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=q2ztoGVGXijg+gcGn8Yxrw4U1f1t39GajkFiNjGt4AQKMsHFOHprE6cEKPtqAXqNl
         bZk41vqjT2DpvLdUl4W/zux1/2aFWQhJYBdECXf6e3qK9eanHY+TFvjtKcwTjpNmiD
         EFHV9rN47niAzt9tdvd0BAr0T0EqsIyZ2p5/dbODXlsuPSI0EyrCO33p8hhVZChHAV
         jJpLFzpZgI/+CG8p9go+RzM8zq4oOjOGCj1qRwO5RF3RQRYCFRsDwcd+sxGj/YggWh
         4QFDh0ZXJ2GBZPdlsjacwajUdq37M2SHCSLxYdCxbt0Imw47ApfGdwSjjppuw0vrcD
         m+8EDwqY7V/Ng==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HIuOma3553405;
        Mon, 17 Jun 2019 11:56:24 -0700
Date:   Mon, 17 Jun 2019 11:56:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-slhnjp06027j3ae17qqetzxj@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        sque@chromium.org, alexander.shishkin@linux.intel.com,
        chongjiang@chromium.org, adrian.hunter@intel.com, acme@redhat.com,
        peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de
Reply-To: peterz@infradead.org, namhyung@kernel.org, acme@redhat.com,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          chongjiang@chromium.org, adrian.hunter@intel.com,
          ak@linux.intel.com, sque@chromium.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          alexey.budankov@linux.intel.com, hpa@zytor.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Document clockid header: HEADER_CLOCKID
Git-Commit-ID: a9de7cfc7663882e98ec3b2ecf35c546a013b956
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

Commit-ID:  a9de7cfc7663882e98ec3b2ecf35c546a013b956
Gitweb:     https://git.kernel.org/tip/a9de7cfc7663882e98ec3b2ecf35c546a013b956
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 29 May 2019 15:43:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:53 -0300

perf data: Document clockid header: HEADER_CLOCKID

We forgot to update the perf.data file format document for the
HEADER_CLOCKID header, do it now from comments in the patch introducing
it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Fixes: cf7905165fee ("perf record: Encode -k clockid frequency into Perf trace")
Link: https://lkml.kernel.org/n/tip-slhnjp06027j3ae17qqetzxj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 99733751695b..600999f89c6d 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -296,6 +296,12 @@ $ perf report --header-only -I
 # memory nodes (nr 1, block size 0x8000000):
 #    0 [7G]: 0-23,32-69
 
+	HEADER_CLOCKID = 23,
+
+One uint64_t for the clockid frequency, specified, for instance, via 'perf
+record -k' (see clock_gettime()), to enable timestamps derived metrics
+conversion into wall clock time on the reporting stage.
+
         HEADER_BPF_PROG_INFO = 25,
 
 struct bpf_prog_info_linear, which contains detailed information about
