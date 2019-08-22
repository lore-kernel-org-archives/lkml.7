Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF1923407
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507713;
	bh=53HkPEh5ROdJAp+fVT7YrnCIvl/qPMl1wb3NNJnhPcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uuP+6GdCqZBDAJc8pAnXNLJwtRKnSgSdFS/L3EH9bBunY19mH+WB2Hvmr5NYmAZm3
	 vKlzl1pc7ZLh+Pix3LYAnTJI0YycaWCugbTnneaXgDnoCfGxJ2KDY+aFXItLvckB7W
	 xgEOp/5ZayCE/a8XcbdojWR9Y3qYZRqnv50lm1ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393382AbfHVVBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389857AbfHVVBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:50 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842C123401;
        Thu, 22 Aug 2019 21:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507709;
        bh=53HkPEh5ROdJAp+fVT7YrnCIvl/qPMl1wb3NNJnhPcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hD8X3CyRiCXD59SAb6K3dqAgOGTRErbCUHJhNYeaDMvKgOZSqnC24Me8HzI6pR5VO
         a61i9HlirNwkLd8Kf/uJhbnZhxCfbGl0SXXWqFoJX5mq48WImVuJ0e8D0i9lPIQFVn
         rvKevkZEYtPWqVTWNkbZTSVnqKasqLJv9nMLdz2s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 09/25] perf counts: Add missing headers needed for types used
Date:   Thu, 22 Aug 2019 18:00:44 -0300
Message-Id: <20190822210100.3461-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We get these by sheer luck, since we're cleaning unneeded headers use,
this needs to be done first to avoid breakage down the line.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p7bncbi53t4p2kobkbmu86a4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/counts.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 13430f353c19..92196df4945f 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -2,8 +2,12 @@
 #ifndef __PERF_COUNTS_H
 #define __PERF_COUNTS_H
 
+#include <linux/types.h>
 #include <internal/xyarray.h>
 #include <perf/evsel.h>
+#include <stdbool.h>
+
+struct evsel;
 
 struct perf_counts {
 	s8			  scaled;
-- 
2.21.0

