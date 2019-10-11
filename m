Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B36C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430321835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824613;
	bh=ljx6XAgvEu+I4iPg53rkaeMnBWo6DSuyKsfaNuyrusI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tpditaw+0wDkWkN5nUjOknt1x6+9ZcZ2ABOtFETjk3FwH2RYgcTOuQngInz28hXNU
	 FF3PGs9uY0MfJZKxINMNEsMYY/ss1XxuivwQTsYZ2eHfkes0K9Yzo9wOqt0gFnVmUo
	 ao00Y9486aCrARVOL8jIOb+SsMGYCTIaaXU3rXwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfJKUKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbfJKUKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:10:12 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DD2C21D71;
        Fri, 11 Oct 2019 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824611;
        bh=ljx6XAgvEu+I4iPg53rkaeMnBWo6DSuyKsfaNuyrusI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W248pszoAgFo1iOpRtqVtF1nQgjTT1p/kepyEOAvAY50qdWpKu04nJHk09kaqp3SI
         b3rADmWhPo80Gf3s2y+eLIFMw7iRnEVrOhHM496Ph5625lSIIzcjCZXXzBuxf/C82m
         4FR2GvWMif8cEHyWcMmTN7Iu3dPWW1RaGqbGUESM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/69] MAINTAINERS: Add entry for perf tool arm64 pmu-events files
Date:   Fri, 11 Oct 2019 17:05:31 -0300
Message-Id: <20191011200559.7156-42-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

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
index 55199ef7fa74..b50ddc863986 100644
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
-- 
2.21.0

