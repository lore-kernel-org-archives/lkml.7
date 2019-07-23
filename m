Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B8C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D002253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OZDaTl7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392190AbfGWVrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:47:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392173AbfGWVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:47:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLl4rJ253003
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:47:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLl4rJ253003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918425;
        bh=H9KbfxF8BQHFZl9IR2r05MTgWvvujShaR8IVagHtCnU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OZDaTl7IFMlnApjBI80Xz7DpuMcsBtjTlxWoTSoU5yBBetvvYOMkkCr1YdjLiNeId
         lkFE3AjhVLnok6T4Y+1x6l2kNH8uKS2YfGcGocG1AF6NIiu8iHgS89TpCAuNK3NEhv
         vblNSIKcVkB4yApccLVIEdYh1G0v998zYZ6brrHYd++lLgn3xqmjyZdshsoje9pPrW
         g63/esvCDVmio+XsD04EZbW6nfvh/DMznlzWb3cQy9d20LTFdrcWXP1QhSBikrgO7c
         u9ht2F+1fdoPn0SKTLxd9y/xf/UUtXdoB6aRt+8E3cPi06yxeVryuE2S2aS0NaHMvQ
         dCWx2bk6TWFWQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLl3Cw253000;
        Tue, 23 Jul 2019 14:47:03 -0700
Date:   Tue, 23 Jul 2019 14:47:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-7db7218a7ea577f04c2df92453d47ab5ebfc8863@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
        ak@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com, ak@linux.intel.com
In-Reply-To: <20190711181922.18765-3-andi@firstfloor.org>
References: <20190711181922.18765-3-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Improve man page description of
 metrics
Git-Commit-ID: 7db7218a7ea577f04c2df92453d47ab5ebfc8863
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

Commit-ID:  7db7218a7ea577f04c2df92453d47ab5ebfc8863
Gitweb:     https://git.kernel.org/tip/7db7218a7ea577f04c2df92453d47ab5ebfc8863
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 11 Jul 2019 11:19:22 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 08:58:11 -0300

perf script: Improve man page description of metrics

Clarify that a metric is based on events, not referring to itself. Also
some improvements with the sentences.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190711181922.18765-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 042b9e5dcc32..caaab28f8400 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -228,11 +228,11 @@ OPTIONS
 
 	With the metric option perf script can compute metrics for
 	sampling periods, similar to perf stat. This requires
-	specifying a group with multiple metrics with the :S option
+	specifying a group with multiple events defining metrics with the :S option
 	for perf record. perf will sample on the first event, and
-	compute metrics for all the events in the group. Please note
+	print computed metrics for all the events in the group. Please note
 	that the metric computed is averaged over the whole sampling
-	period, not just for the sample point.
+	period (since the last sample), not just for the sample point.
 
 	For sample events it's possible to display misc field with -F +misc option,
 	following letters are displayed for each bit:
