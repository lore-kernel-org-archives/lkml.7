Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81254C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4888C206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="1JKAY8QT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbfG2VgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:36:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbfG2VgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:36:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLZwQd2941528
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:35:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLZwQd2941528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564436159;
        bh=ERBr+GSF9F1z/TN81ajdqUdzxhemesxLDDpDw3y5L5Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=1JKAY8QT+UHeRXnWeLJug4uCOEwdkBr8Jub+WSkRj/OuRsznvrmZVPxenwKgVDOkN
         CC3sAiDPU4cAhH9ojvZ6iZqystyTuTASJSoJthdp0EduK0/heLrYZdArn79UjOyLQr
         EMYyon/MslHuYLxQc7r4mPF/UedTu4IvJ1WN147ZT8/L/Nj6F3hjV6GJL64wr3Fstv
         nTtlN4HkbMxm0gFWEJil5bcd63tCoGvIh6fGx/tcVYYH2GD7v8U6lQeWxybKfO+dbc
         AgyO+2Uk3Lt6fDhi2GD5Btr90dSQP1AslgaY5PdVcp4d8NJTCt260H1oBWoaQGfjcD
         q+RibbOGg0kuA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLZwAX2941525;
        Mon, 29 Jul 2019 14:35:58 -0700
Date:   Mon, 29 Jul 2019 14:35:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vince Weaver <tipbot@zytor.com>
Message-ID: <tip-2e9a06dda10aea81a17c623f08534dac6735434a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@redhat.com, namhyung@kernel.org, acme@redhat.com,
        hpa@zytor.com, vincent.weaver@maine.edu, peterz@infradead.org
Reply-To: hpa@zytor.com, peterz@infradead.org, vincent.weaver@maine.edu,
          acme@redhat.com, namhyung@kernel.org, jolsa@redhat.com,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <alpine.DEB.2.21.1907251155500.22624@macbook-air>
References: <alpine.DEB.2.21.1907251155500.22624@macbook-air>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix perf.data documentation units for
 memory size
Git-Commit-ID: 2e9a06dda10aea81a17c623f08534dac6735434a
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

Commit-ID:  2e9a06dda10aea81a17c623f08534dac6735434a
Gitweb:     https://git.kernel.org/tip/2e9a06dda10aea81a17c623f08534dac6735434a
Author:     Vince Weaver <vincent.weaver@maine.edu>
AuthorDate: Thu, 25 Jul 2019 11:57:43 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 09:03:43 -0300

perf tools: Fix perf.data documentation units for memory size

The perf.data-file-format documentation incorrectly says the
HEADER_TOTAL_MEM results are in bytes.  The results are in kilobytes
(perf reads the value from /proc/meminfo)

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1907251155500.22624@macbook-air
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 5f54feb19977..d030c87ed9f5 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -126,7 +126,7 @@ vendor,family,model,stepping. For example: GenuineIntel,6,69,1
 
 	HEADER_TOTAL_MEM = 10,
 
-An uint64_t with the total memory in bytes.
+An uint64_t with the total memory in kilobytes.
 
 	HEADER_CMDLINE = 11,
 
