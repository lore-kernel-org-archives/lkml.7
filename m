Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82486C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5740420872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nuky1RiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfERJ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:28:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:28:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9Rv2Y1741657
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:27:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9Rv2Y1741657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171678;
        bh=rpOhxogJtYuCl8ipWCceQu79nPD2WljgrHaREOEDxSo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nuky1RiDI/bR+GqluWE2306wgV7vOoopfiEcro2uUn+iXg6FP5cJhNFkNwh1j0k99
         10zdGtaFD323+sKac86E7y1wh0/J2uWxpAzQMB9atsVVR3rKq5FmX7E0Z/uI4VkWu3
         WiWEdqZdoiBXoAzDeMMVviT609uXfAggOqIQaevvwijq8dMKFWhfR9yWEKXak7aDiX
         Kx9ocnSZiMOVwp6DyiLektgeoXTTYe+O/uQWLVqlFN7Eas1jFc6EmHXlZrsrc5lVm5
         nSM1oz8oX5j3/YDZQRUWB6YZBFMwrq8eoRE0KKlaiP4KRftNkJ+99ZjW0bMJU/uOAL
         ER3v52HLI9AFg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9RumT1741654;
        Sat, 18 May 2019 02:27:56 -0700
Date:   Sat, 18 May 2019 02:27:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zenghui Yu <tipbot@zytor.com>
Message-ID: <tip-8e8f515d567f9ec1d960e9fdb117d39753b7504d@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@kernel.org, yuzenghui@huawei.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, hpa@zytor.com,
        tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, john.garry@huawei.com,
          hpa@zytor.com, jolsa@redhat.com, tglx@linutronix.de,
          acme@redhat.com, namhyung@kernel.org, yuzenghui@huawei.com,
          mingo@kernel.org, peterz@infradead.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <1557919169-23972-1-git-send-email-yuzenghui@huawei.com>
References: <1557919169-23972-1-git-send-email-yuzenghui@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf jevents: Remove unused variable
Git-Commit-ID: 8e8f515d567f9ec1d960e9fdb117d39753b7504d
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

Commit-ID:  8e8f515d567f9ec1d960e9fdb117d39753b7504d
Gitweb:     https://git.kernel.org/tip/8e8f515d567f9ec1d960e9fdb117d39753b7504d
Author:     Zenghui Yu <yuzenghui@huawei.com>
AuthorDate: Wed, 15 May 2019 11:19:29 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf jevents: Remove unused variable

Address gcc warning:

  pmu-events/jevents.c: In function ‘save_arch_std_events’:
  pmu-events/jevents.c:417:15: warning: unused variable ‘sb’ [-Wunused-variable]
    struct stat *sb = data;
                 ^~

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: wanghaibin.wang@huawei.com
Link: http://lkml.kernel.org/r/1557919169-23972-1-git-send-email-yuzenghui@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index daaea5003d4a..58f77fd0f59f 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -415,7 +415,6 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *metric_name, char *metric_group)
 {
 	struct event_struct *es;
-	struct stat *sb = data;
 
 	es = malloc(sizeof(*es));
 	if (!es)
