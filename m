Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FF0C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A9D20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LmIRXJlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfERJ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:29:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36873 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:29:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9SbQB1741702
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:28:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9SbQB1741702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171718;
        bh=OYO1dEpwtT8tsV0G7vOWkq3vMUO4g8iPMYFe5WSBVd8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LmIRXJlo9DqMRnxNH9H0D7enHXU8liWJPqd0FZ5YGiPx02UthGUqLjN8mrhCwHWge
         5jl3u3IVn6pzk+76HXSlC+luKdBP+jXrwdla0VulPsYSfAeh+LRU+xmS/9HH27GX87
         o8LJmx9AW47vvbJelaWHGdEhZDB8A3cCiZGs2vwrCfuCzPL+ZdT/Q7uELDqFCjHtWY
         zI2/6r9F7pPKnNZ/qKeETsb6BI5KCP9fkX2baU6ukGm240otyO0ZfXV6JvQjIVT3Jh
         nR5ug/qD7QehwHYgNEKfBLdYuL1LHyTWt8KlZN2GEniztqLupdiAHhKFkzjqHPlHS5
         bTrMeDSg3qHHQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9Sao31741699;
        Sat, 18 May 2019 02:28:36 -0700
Date:   Sat, 18 May 2019 02:28:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Florian Fainelli <tipbot@zytor.com>
Message-ID: <tip-ae833a6124b1bfe98bea428da86fe5b83b5785a7@git.kernel.org>
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, f.fainelli@gmail.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        peterz@infradead.org, hpa@zytor.com,
        ganapatrao.kulkarni@cavium.com, will.deacon@arm.com,
        acme@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        seanvk.dev@oregontracks.org, namhyung@kernel.org,
        john.garry@huawei.com
Reply-To: john.garry@huawei.com, seanvk.dev@oregontracks.org,
          namhyung@kernel.org, will.deacon@arm.com, acme@redhat.com,
          tglx@linutronix.de, mingo@kernel.org, jolsa@redhat.com,
          peterz@infradead.org, hpa@zytor.com,
          ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
          mark.rutland@arm.com, catalin.marinas@arm.com,
          alexander.shishkin@linux.intel.com, f.fainelli@gmail.com
In-Reply-To: <20190513202522.9050-2-f.fainelli@gmail.com>
References: <20190513202522.9050-2-f.fainelli@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: Remove [[:xdigit:]]
 wildcard
Git-Commit-ID: ae833a6124b1bfe98bea428da86fe5b83b5785a7
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

Commit-ID:  ae833a6124b1bfe98bea428da86fe5b83b5785a7
Gitweb:     https://git.kernel.org/tip/ae833a6124b1bfe98bea428da86fe5b83b5785a7
Author:     Florian Fainelli <f.fainelli@gmail.com>
AuthorDate: Mon, 13 May 2019 13:25:20 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf vendor events arm64: Remove [[:xdigit:]] wildcard

ARM64's implementation of get_cpuidr_str() masks out the revision bits
[3:0] while reading the CPU identifier, there is no need for the
[[:xdigit:]] wildcard.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean V Kelley <seanvk.dev@oregontracks.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org (moderated list:arm pmu profiling and debugging)
Link: http://lkml.kernel.org/r/20190513202522.9050-2-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 59cd8604b0bd..da5ff2204bf6 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,7 +12,7 @@
 #
 #
 #Family-model,Version,Filename,EventType
-0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
+0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
